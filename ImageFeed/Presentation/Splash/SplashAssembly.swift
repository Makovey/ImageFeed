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
        
        let oAuthService: IOAuth2Service = OAuth2Service()
        let storage: IOAuth2TokenStorage = OAuth2TokenStorage()
        let profileService: IProfileService = ProfileService(storage: storage)

        let presenter = SplashPresenter(
            oAuthService: oAuthService,
            profileService: profileService,
            storage: storage
        )
        
        view.presenter = presenter
        router.viewController = view
        presenter.router = router
        presenter.view = view
        
        return view
    }
}
