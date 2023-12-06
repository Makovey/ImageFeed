//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 27.11.2023.
//

import Foundation

protocol IOAuth2Service {
    func fetchToken(code: String, completion: @escaping (Result<OAuth2TokenResponse, ServiceError>) -> Void)
}

final class OAuth2Service: IOAuth2Service {
    private struct Constant {
        static let baseUrl = "https://unsplash.com/oauth"
        static let tokenUrl = "/token"
        
        static let clientId = "client_id"
        static let clientSecret = "client_secret"
        static let redirectUri = "redirect_uri"
        static let code = "code"
        static let grantType = "grant_type"
        static let authCode = "authorization_code"
    }
    
    private var task: URLSessionTask?
    private var lastCode: String?
    
    func fetchToken(code: String, completion: @escaping (Result<OAuth2TokenResponse, ServiceError>) -> Void) {
        assert(Thread.isMainThread)
        guard lastCode != code else { return }
        task?.cancel()
        lastCode = code
        
        var performer = RequestPerformer(
            url: Constant.baseUrl + Constant.tokenUrl,
            method: .postMethod,
            token: nil
        )
        
        performer.pathParams = [
            URLQueryItem(name: Constant.clientId, value: AppConstant.accessKey),
            URLQueryItem(name: Constant.clientSecret, value: AppConstant.secretKey),
            URLQueryItem(name: Constant.redirectUri, value: AppConstant.redirectUri),
            URLQueryItem(name: Constant.code, value: code),
            URLQueryItem(name: Constant.grantType, value: Constant.authCode)
        ]
        
        performer.body = [
            Constant.clientId: AppConstant.accessKey,
            Constant.clientSecret: AppConstant.secretKey,
            Constant.redirectUri: AppConstant.redirectUri,
            Constant.code: code,
            Constant.grantType: Constant.authCode
        ]
        
        task = performer.perform { (result: Result<OAuth2TokenResponse, ServiceError>) in
            self.task = nil
            self.lastCode = nil
            completion(result)
        }
    }
}
