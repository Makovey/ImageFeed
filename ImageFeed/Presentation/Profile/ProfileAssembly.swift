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
        let presenter = ProfilePresenter(profileData: profileData)
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
