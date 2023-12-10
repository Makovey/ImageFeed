//
//  Photo.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 09.12.2023.
//

import Foundation

struct PhotoViewModel {
    let id: String
    let size: CGSize
    let createdAt: Date
    let welcomeDescription: String?
    let thumbImageUrl: String
    let largeImageUrl: String
    let isLiked: Bool
}
