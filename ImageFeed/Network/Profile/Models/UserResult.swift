//
//  UserResult.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 01.12.2023.
//

import Foundation

struct UserResult: Decodable {
    let profileImage: ProfileImage

    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
    
    struct ProfileImage: Decodable {
        let large: String
    }
}
