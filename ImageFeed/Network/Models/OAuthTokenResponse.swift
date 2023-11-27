//
//  OAuthTokenResponseBody.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 27.11.2023.
//

import Foundation

struct OAuthTokenResponse: Decodable {
    let accessToken: String
    let tokenType: TokenType
    let scope: String
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
        case createdAt = "created_at"
    }
    
    enum TokenType: String, Decodable {
        case bearer = "Bearer"
    }
}
