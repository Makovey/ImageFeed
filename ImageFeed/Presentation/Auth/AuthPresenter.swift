//
//  AuthPresenter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 26.11.2023.
//

import Foundation

protocol IAuthPresenter {
    func didLoginButtonTapped()
}

final class AuthPresenter: IAuthPresenter {

    // MARK: - Dependencies
    
    var router: IAuthRouter?
        
    func didLoginButtonTapped() {
        router?.openWebView()
    }
}
