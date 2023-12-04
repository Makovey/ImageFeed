//
//  AppConstant.swift
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
}
