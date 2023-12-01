//
//  ProfileService.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 30.11.2023.
//

import Foundation

protocol IProfileService {
    func fetchProfile(completion: @escaping (Result<ProfileResult, ServiceError>) -> Void)
}

final class ProfileService: IProfileService {
    private struct Constant {
        static let baseUrl = "https://api.unsplash.com"
        static let profileEndpoint = "/me"
        
        static let bearer = "Bearer"
        static let authorization = "Authorization"
    }
    
    // MARK: - Properties

    private let storage: IOAuth2TokenStorage
    
    // MARK: - Init
    
    init(storage: IOAuth2TokenStorage) {
        self.storage = storage
    }
    
    func fetchProfile(completion: @escaping (Result<ProfileResult, ServiceError>) -> Void) {
        let performer = RequestPerformer(
            url: "\(Constant.baseUrl)\(Constant.profileEndpoint)",
            method: .getMethod,
            token: storage.token
        )

        performer.perform { (result: Result<ProfileResult, ServiceError>) in
            completion(result)
        }
    }
}
