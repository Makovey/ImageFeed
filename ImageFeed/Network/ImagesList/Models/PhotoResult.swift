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
    let createdAt: Date?
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

extension PhotoResult  {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        
        let createdAtString = try? container.decode(String.self, forKey: .createdAt)
        if let createdAtString {
            createdAt = ISO8601DateFormatter().date(from: createdAtString)
        } else {
            createdAt = nil
        }

        description = try? container.decode(String.self, forKey: .description)
        likedByUser = try container.decode(Bool.self, forKey: .likedByUser)
        urls = try container.decode(URLResult.self, forKey: .urls)
    }
}
