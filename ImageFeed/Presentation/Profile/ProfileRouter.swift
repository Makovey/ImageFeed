//
//  ProfileRouter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 18.12.2023.
//

import Foundation
import UIKit

protocol IProfileRouter {
    func logout()
}

final class ProfileRouter: IProfileRouter {
    
    // MARK: - Dependencies

    weak var viewController: UIViewController?
    
    // MARK: - IProfileRouter
    
    func logout() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        
        let splashModule = SplashAssembly.assemble()
        window.rootViewController = splashModule
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: nil)
    }
}
