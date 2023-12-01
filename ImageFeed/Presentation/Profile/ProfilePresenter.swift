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
    private let service: IProfileService
    
    // MARK: - Init

    init(service: IProfileService) {
        self.service = service
    }
    
    func viewDidLoad() {
        service.fetchProfile { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case let .success(model):
                    let viewModel = self.makeProfileViewModel(data: model)
                    self.view?.updateProfileData(data: viewModel)
                case let .failure(error):
                    self.view?.showError(error: error.localizedDescription)
                }
            }
        }
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
