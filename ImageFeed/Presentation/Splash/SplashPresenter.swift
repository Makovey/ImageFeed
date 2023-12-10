//
//  SplashPresenter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 28.11.2023.
//

import Foundation

protocol ISplashPresenter {
    func loadData()
    func didAuthenticated(with code: String)
}

final class SplashPresenter: ISplashPresenter {
    
    // MARK: - Properties
    
    weak var view: ISplashViewController?
    var router: ISplashRouter?
    private let oAuthService: IOAuth2Service
    private let profileService: IProfileService
    private let profileImageService: IProfileImageService
    private var storage: IOAuth2TokenStorage
    
    // MARK: - Init

    init(
        oAuthService: IOAuth2Service,
        profileService: IProfileService,
        profileImageService: IProfileImageService,
        storage: IOAuth2TokenStorage
    ) {
        self.oAuthService = oAuthService
        self.profileService = profileService
        self.profileImageService = profileImageService
        self.storage = storage
    }
    
    func loadData() {
        guard storage.token != nil else {
            router?.openAuthFlow()
            return
        }
        
        fetchProfileData()
    }
    
    func didAuthenticated(with code: String) {
        view?.showLoader()
        oAuthService.fetchToken(code: code) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let success):
                self.storage.token = success.accessToken
                self.fetchProfileData()
            case .failure:
                self.view?.dismissLoader()
                self.view?.showAlert() { self.loadData() }
            }
        }
    }
    
    private func fetchProfileData() {
        profileService.fetchProfile { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case let .success(model):
                    if let username = model.username {
                        self.profileImageService.fetchProfileImageURL(username: username)
                    }
                    self.view?.dismissLoader()
                    self.router?.openImageList(profileData: model)
                case .failure:
                    self.view?.dismissLoader()
                    self.view?.showAlert() { self.fetchProfileData() }
                }
            }
        }
    }
}
