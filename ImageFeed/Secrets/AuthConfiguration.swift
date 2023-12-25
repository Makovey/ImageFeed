//
//  AuthConfiguration.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 05.11.2023.
//

import Foundation

/// Изначально должно лежать в .gitignore, только для проверки ревьюером оставляю тут

struct AppConstant {
    static let accessKey = "7NqOOnlcFvETBg-d_4pUk7Sw8ZJ2j79lynh3WfdZzUY"
    static let secretKey = "t_uCQ1sQZrLrngJSTV2L_A9Jby1-rvDXUfRd8cJZvF4"
    static let redirectUri = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL = "https://api.unsplash.com"
    static let authorizeUrl = "https://unsplash.com/oauth/authorize"
}

struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectUri: String
    let accessScope: String
    let defaultBaseURL: String
    let authorizeUrl: String
    
    static var standart: AuthConfiguration {
        .init(
            accessKey: AppConstant.accessKey,
            secretKey: AppConstant.secretKey,
            redirectUri: AppConstant.redirectUri,
            accessScope: AppConstant.accessScope,
            defaultBaseURL: AppConstant.defaultBaseURL,
            authorizeUrl: AppConstant.authorizeUrl
        )
    }
}
