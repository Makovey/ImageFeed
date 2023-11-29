//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 27.11.2023.
//

import Foundation

protocol IOAuth2Service {
    func fetchToken(code: String, completion: @escaping (Result<OAuthTokenResponse, OAuth2ServiceError>) -> Void)
}

final class OAuth2Service: IOAuth2Service {
    private struct Constant {
        static let baseUrl = "https://unsplash.com/oauth"
        static let tokenUrl = "/token"
        static let authCode = "authorization_code"
    }
    
    func fetchToken(code: String, completion: @escaping (Result<OAuthTokenResponse, OAuth2ServiceError>) -> Void) {
        var urlComponents = URLComponents(string: Constant.baseUrl + Constant.tokenUrl)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: AppConstant.accessKey),
            URLQueryItem(name: "client_secret", value: AppConstant.secretKey),
            URLQueryItem(name: "redirect_uri", value: AppConstant.redirectUri),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: Constant.authCode)
        ]
        
        guard let url = urlComponents?.url else {
            completion(.failure(.invalidUrlError))
            return
        }
        
        guard let query = url.query else {
            completion(.failure(.invalidUrlError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = Data(query.utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.noInternetConnectionError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.serverError))
                return
            }
            
            guard let data, !data.isEmpty else {
                completion(.failure(.emptyDataError))
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode(OAuthTokenResponse.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(.invalidParsingError))
            }
        }.resume()
    }
}
