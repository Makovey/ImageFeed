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
        static let usersEndpoint = "/users/"
        
        static let notificationName = "ProfileImageProviderDidChange"
        static let url = "URL"
    }
    
    // MARK: - Properties
    
    static let shared = ProfileImageService()
    static let didChangeNotificationName = Notification.Name(Constant.notificationName)
    
    private let storage: IOAuth2TokenStorage = OAuth2TokenStorage()
    private (set) var avatarURL: String?
        
    func fetchProfileImageURL(
        username: String
    ) {
        let performer: IRequestPerformer = RequestPerformer(
            url: AppConstant.defaultBaseURL + Constant.usersEndpoint + username,
            method: .getMethod,
            token: storage.token
        )
        
        performer.perform { [weak self] (result: Result<UserResult, ServiceError>) in
            guard let self else { return }
            
            switch result {
            case let .success(userResult):
                self.avatarURL = userResult.profileImage.medium
                NotificationCenter.default.post(
                    name: ProfileImageService.didChangeNotificationName,
                    object: self,
                    userInfo: [Constant.url: userResult.profileImage.medium]
                )
            case .failure:
                break // TODO: error handling
            }
        }
    }
}
