//
//  AuthHelper.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 22.12.2023.
//

import Foundation

protocol IAuthHelper {
    func makeAuthRequest() -> URLRequest?
    func code(from url: URL) -> String?
}

final class AuthHelper: IAuthHelper {
    private struct Constant {
        static let authorizePath = "/oauth/authorize/native"
        static let code = "code"
    }
    
    // MARK: - Dependencies
    
    let configuration: AuthConfiguration
    
    // MARK: - Init
    
    init(configuration: AuthConfiguration = .standart) {
        self.configuration = configuration
    }
    
    func makeAuthRequest() -> URLRequest? {
        guard let url = makeAuthURL() else { return nil }
        return URLRequest(url: url)
    }
    
    func code(from url: URL) -> String? {
        guard let urlComponents = URLComponents(string: url.absoluteString),
              urlComponents.path == Constant.authorizePath,
              let items = urlComponents.queryItems,
              let codeItem = items.first(where: { $0.name == Constant.code })
        else { return nil }
        
        return codeItem.value
    }
    
    private func makeAuthURL() -> URL? {
        guard var urlComponents = URLComponents(string: configuration.authorizeUrl) else { return nil }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: configuration.accessKey),
            URLQueryItem(name: "redirect_uri", value: configuration.redirectUri),
            URLQueryItem(name: "response_type", value: Constant.code),
            URLQueryItem(name: "scope", value: configuration.accessScope)
        ]
        
        guard let url = urlComponents.url else { return nil }
        
        return url
    }
}
