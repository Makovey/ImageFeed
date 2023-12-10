//
//  PhotoResult.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 09.12.2023.
//

import Foundation

struct PhotoResult: Decodable {
    let id: String
    let width: Int
    let height: Int
    let createdAt: Date
    let description: String?
    let likedByUser: Bool
    let urls: URLResult
    
    struct URLResult: Decodable {
        let thumb: String
        let full: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case createdAt = "created_at"
        case description
        case urls
        case likedByUser = "liked_by_user"
    }
}
