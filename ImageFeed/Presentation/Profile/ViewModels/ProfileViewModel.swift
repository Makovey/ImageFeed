//
//  ProfileViewModel.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 30.11.2023.
//

import Foundation

struct ProfileViewModel {
    let username: String?
    let name: String?
    let loginName: String?
    let bio: String?
}

// MARK: - Equitable

extension ProfileViewModel: Equatable {}
