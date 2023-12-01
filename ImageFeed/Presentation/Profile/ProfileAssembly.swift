//
//  ProfileViewAssembly.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 29.10.2023.
//

import UIKit

final class ProfileAssembly {
    static func assemble() -> UIViewController {
        let view = ProfileViewController()
        
        let storage: IOAuth2TokenStorage = OAuth2TokenStorage()
        let service: IProfileService = ProfileService(storage: storage)
        let presenter = ProfilePresenter(service: service)
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
