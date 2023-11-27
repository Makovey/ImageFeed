//
//  AuthPresenter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 26.11.2023.
//

import Foundation

protocol IAuthPresenter {
    func didLoginButtonTapped()
    func didAuthenticated(with code: String)
}

final class AuthPresenter: IAuthPresenter {

    // MARK: - Dependencies
    
    var router: IAuthRouter?
    private let service: IOAuth2Service
    private var storage: IOAuth2TokenStorage
    
    init(
        service: IOAuth2Service,
        storage: IOAuth2TokenStorage
    ) {
        self.service = service
        self.storage = storage
    }
    
    func didLoginButtonTapped() {
        router?.openWebView()
    }
    
    func didAuthenticated(with code: String) {
        service.fetchToken(code: code) { [weak self] result in
            guard let self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.storage.token = success.accessToken
                case .failure:
                    break // TODO: error handling
                }
            }
        }
    }
}
