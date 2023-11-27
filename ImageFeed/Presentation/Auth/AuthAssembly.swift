//
//  AuthAssembly.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 26.11.2023.
//

import UIKit

final class AuthAssembly {
    static func assemble() -> UIViewController {
        let view = AuthViewController()
        let router = AuthRouter()
        
        let service: IOAuth2Service = OAuth2Service()
        let storage: IOAuth2TokenStorage = OAuth2TokenStorage()
        let presenter = AuthPresenter(service: service, storage: storage)
        
        view.presenter = presenter
        router.viewController = view
        presenter.router = router
        
        return view
    }
}
