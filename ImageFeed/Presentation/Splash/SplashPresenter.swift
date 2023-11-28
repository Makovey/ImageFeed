//
//  SplashPresenter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 28.11.2023.
//

import Foundation

protocol ISplashPresenter {
    func checkUserAuth()
    func didAuthenticated(with code: String)
}

final class SplashPresenter: ISplashPresenter {
    
    // MARK: - Properties
    
    var router: ISplashRouter?
    private let service: IOAuth2Service
    private var storage: IOAuth2TokenStorage
    
    // MARK: - Init

    init(
        service: IOAuth2Service,
        storage: IOAuth2TokenStorage
    ) {
        self.service = service
        self.storage = storage
    }
    
    func checkUserAuth() {
        guard storage.token != nil else {
            router?.openAuthFlow()
            return
        }
        
        router?.openImageList()
    }
    
    func didAuthenticated(with code: String) {
        service.fetchToken(code: code) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let success):
                self.storage.token = success.accessToken
                self.router?.openImageList()
            case .failure:
                break // TODO: error handling
            }
        }
    }
}
