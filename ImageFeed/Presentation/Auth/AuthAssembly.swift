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
        let presenter = AuthPresenter()
        
        view.presenter = presenter
        router.viewController = view
        presenter.router = router
        
        return view
    }
}
