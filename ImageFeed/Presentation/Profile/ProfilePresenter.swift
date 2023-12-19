//
//  ProfilePresenter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 30.11.2023.
//

import Foundation

protocol IProfilePresenter {
    func viewDidLoad()
    func exitButtonTapped()
}

final class ProfilePresenter: IProfilePresenter {
    
    // MARK: - Properties

    weak var view: IProfileViewController?
    var router: IProfileRouter?
    
    private let profileData: ProfileResult
    private var storage: IOAuth2TokenStorage
    private var profileImageServiceObserver: NSObjectProtocol?
    
    // MARK: - Init

    init(
        profileData: ProfileResult,
        storage: IOAuth2TokenStorage
    ) {
        self.profileData = profileData
        self.storage = storage
    }
    
    func viewDidLoad() {
        let viewModel = makeProfileViewModel(data: profileData)
        view?.updateProfileData(data: viewModel)
        addAvatarUrlObserver()
    }
    
    func exitButtonTapped() {
        storage.removeToken()
        WKCacheCleaner.clean()
        
        router?.logout()
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
        
        view?.updateAvatar(with: url)
    }
}
