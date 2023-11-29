//
//  SplashAssembly.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 28.11.2023.
//

import UIKit

final class SplashAssembly {
    static func assemble() -> UIViewController {
        let view = SplashViewController()
        let router = SplashRouter()
        
        let service: IOAuth2Service = OAuth2Service()
        let storage: IOAuth2TokenStorage = OAuth2TokenStorage()
        let presenter = SplashPresenter(service: service, storage: storage)
        
        view.presenter = presenter
        router.viewController = view
        presenter.router = router
        
        return view
    }
}
