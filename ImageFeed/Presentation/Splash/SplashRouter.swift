//
//  SplashRouter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 28.11.2023.
//

import UIKit

protocol ISplashRouter {
    func openAuthFlow()
    func openImageList(profileData: ProfileResult)
}

final class SplashRouter: ISplashRouter {
    
    // MARK: - Properties
    
    weak var viewController: SplashViewController?
    
    func openAuthFlow() {
        guard let viewController else { return }
        
        let destination = AuthAssembly.assemble(delegate: viewController)
        destination.modalPresentationStyle = .fullScreen
        viewController.present(destination, animated: true)
    }
    
    func openImageList(profileData: ProfileResult) {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        
        let tabBar = TabBarController(profileData: profileData)
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: nil)
    }
}
