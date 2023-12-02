//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 01.12.2023.
//

import Foundation

protocol IProfileImageService {
    func fetchProfileImageURL(username: String)
}

final class ProfileImageService {
    private struct Constant {
        static let baseUrl = "https://api.unsplash.com"
        static let usersEndpoint = "/users/"
        
        static let users = "users"
    }
    
    // MARK: - Properties
    
    static let shared = ProfileImageService()
    
    private let storage: IOAuth2TokenStorage = OAuth2TokenStorage()
    private (set) var avatarURL: String?
        
    func fetchProfileImageURL(
        username: String
    ) {
        let performer: IRequestPerformer = RequestPerformer(
            url: "\(Constant.baseUrl)\(Constant.usersEndpoint)\(username)",
            method: .getMethod,
            token: storage.token
        )
        
        performer.perform { (result: Result<UserResult, ServiceError>) in
            switch result {
            case let .success(userResult):
                self.avatarURL = userResult.profileImage.medium
            case .failure:
                break // TODO: error handling
            }
        }
    }
}
