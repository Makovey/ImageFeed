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
    
    // MARK: - Init

    init(profileData: ProfileResult) {
        self.profileData = profileData
    }
    
    func viewDidLoad() {
        let viewModel = makeProfileViewModel(data: profileData)
        view?.updateProfileData(data: viewModel)
    }
    
    private func makeProfileViewModel(data: ProfileResult) -> ProfileViewModel {
        ProfileViewModel(
            username: data.username ?? "",
            name: "\(data.firstName ?? "") \(data.lastName ?? "")",
            loginName: data.username != nil ? "@\(data.username!)" : "",
            bio: data.bio
        )
    }
}
