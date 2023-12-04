//
//  ProfilePresenter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 30.11.2023.
//

import Foundation

protocol IProfilePresenter {
    func viewDidLoad()
}

final class ProfilePresenter: IProfilePresenter {
    
    // MARK: - Properties

    var view: IProfileViewController?
    private let profileData: ProfileResult
    private var profileImageServiceObserver: NSObjectProtocol?
    
    // MARK: - Init

    init(profileData: ProfileResult) {
        self.profileData = profileData
    }
    
    func viewDidLoad() {
        let viewModel = makeProfileViewModel(data: profileData)
        view?.updateProfileData(data: viewModel)
        addAvatarUrlObserver()
    }
    
    private func addAvatarUrlObserver() {
        profileImageServiceObserver = NotificationCenter.default.addObserver(
            forName: ProfileImageService.didChangeNotificationName,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            self.makeAvatar()
        }
        
        makeAvatar()
    }
    
    private func makeProfileViewModel(data: ProfileResult) -> ProfileViewModel {
        .init(
            username: data.username ?? "",
            name: "\(data.firstName ?? "") \(data.lastName ?? "")",
            loginName: data.username != nil ? "@\(data.username!)" : "",
            bio: data.bio
        )
    }
    
    private func makeAvatar() {
        guard let profileImage = ProfileImageService.shared.avatarURL,
              let url = URL(string: profileImage)
        else { return }
        
        print(url)
    }
}
