//
//  AuthRouter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 26.11.2023.
//

import UIKit

protocol IAuthRouter {
    func openWebView()
}

final class AuthRouter: IAuthRouter {
    
    // MARK: - Dependencies

    weak var viewController: AuthViewController?
    
    func openWebView() {
        guard let viewController else { return }
        
        let destination = WebViewAssembly.assemble(delegate: viewController)
        destination.modalPresentationStyle = .fullScreen
        viewController.present(destination, animated: true)
    }
}
