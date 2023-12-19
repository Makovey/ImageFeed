//
//  OAuth2TokenResponseBody.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 27.11.2023.
//

import Foundation

struct OAuth2TokenResponse: Decodable {
    let accessToken: String
    let tokenType: TokenType
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
    
    enum TokenType: String, Decodable {
        case bearer = "Bearer"
    }
}
