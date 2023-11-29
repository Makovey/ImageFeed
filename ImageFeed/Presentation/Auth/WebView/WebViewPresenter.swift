//
//  WebViewPresenter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 26.11.2023.
//

import Foundation
import WebKit

protocol IWebViewPresenter {
    func makeUrlRequest() -> URLRequest?
    func getCode(from: WKNavigationAction) -> String?
}

final class WebViewPresenter: IWebViewPresenter {
    private struct Constant {
        static let authorizeUrl = "https://unsplash.com/oauth/authorize"
        static let authorizePath = "/oauth/authorize/native"
        static let code = "code"
    }
    
    func makeUrlRequest() -> URLRequest?  {
        guard var urlComponents = URLComponents(string: Constant.authorizeUrl) else { return nil }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: AppConstant.accessKey),
            URLQueryItem(name: "redirect_uri", value: AppConstant.redirectUri),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: AppConstant.accessScope)
        ]
        
        guard let url = urlComponents.url else { return nil}
        
        return URLRequest(url: url)
    }
    
    func getCode(from navigationAction: WKNavigationAction) -> String? {
        guard let url = navigationAction.request.url,
              let urlComponents = URLComponents(string: url.absoluteString),
              urlComponents.path == Constant.authorizePath,
              let items = urlComponents.queryItems,
              let codeItem = items.first(where: { $0.name == Constant.code })
        else { return nil }
        
        return codeItem.value
    }
}
