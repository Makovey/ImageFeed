//
//  RequestPerformer.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 30.11.2023.
//

import Foundation

protocol IRequestPerformer {
    func perform<ResponseModel: Decodable>(
        completion: @escaping (Result<ResponseModel, ServiceError>) -> Void
    )
    
    var pathParams: [URLQueryItem]? { get set }
    var queryParams: [QueryParameter]? { get set }
    var body: [String: Any]? { get set }
}

struct RequestPerformer: IRequestPerformer {
    private struct Constant {
        static let bearer = "Bearer"
        static let authorization = "Authorization"
    }
        
    var pathParams: [URLQueryItem]?
    var queryParams: [QueryParameter]?
    var body: [String: Any]?
    private let url: String
    private let method: HttpMethod
    private let token: String?
    
    init(
        url: String,
        method: HttpMethod,
        token: String?
    ) {
        self.url = url
        self.method = method
        self.token = token
    }
    
    func perform<ResponseModel: Decodable>(
        completion: @escaping (Result<ResponseModel, ServiceError>) -> Void
    ) {
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = pathParams
        
        guard let url = urlComponents?.url else {
            completion(.failure(.invalidUrlError))
            return
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let token {
            request.setValue("\(Constant.bearer) \(token)", forHTTPHeaderField: "\(Constant.authorization)")
        }
        
        if let body {
            let data = try? JSONSerialization.data(withJSONObject: body)
            guard let data else {
                completion(.failure(.serializeBodyError))
                return
            }

            request.httpBody = data
        }
        
        queryParams?
            .forEach {
                request.setValue("\($0.value)", forHTTPHeaderField: "\($0.forHeader)")
            }
        
        print("""
        DEBUG:
        URL: \(url.absoluteString)
        Method: \(method.rawValue)
        Token: \(token ?? "")
        PathParams: \(pathParams ?? [])
        QueryParams: \(queryParams ?? [])
        Body: \(body ?? [:])
        ----
        """)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.noInternetConnectionError))
                print("DEBUG: \(ServiceError.noInternetConnectionError.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.serverError))
                print("DEBUG: \(ServiceError.serverError.localizedDescription)")
                return
            }

            guard let data, !data.isEmpty else {
                completion(.failure(.emptyDataError))
                print("DEBUG: \(ServiceError.emptyDataError.localizedDescription)")
                return
            }

            do {
                let responseData = try JSONDecoder().decode(ResponseModel.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(.invalidParsingError))
                print("DEBUG: \(ServiceError.invalidParsingError.localizedDescription)")
            }
        }.resume()
    }
}
