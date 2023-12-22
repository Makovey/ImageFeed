//
//  ProfileViewAssembly.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 29.10.2023.
//

import UIKit

final class ProfileAssembly {
    static func assemble(profileData: ProfileResult) -> UIViewController {
        let view = ProfileViewController()
        let storage = OAuth2TokenStorage()
        let presenter = ProfilePresenter(profileData: profileData, storage: storage)
        let router = ProfileRouter()
        
        view.presenter = presenter
        router.viewController = view
        presenter.view = view
        presenter.router = router
        
        return view
    }
}
