//
//  WebViewAssembly.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 26.11.2023.
//

import UIKit

final class WebViewAssembly {
    static func assemble(delegate: IWebViewViewControllerDelegate) -> UIViewController {
        let view = WebViewViewController()
        
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        
        view.presenter = presenter
        view.delegate = delegate
        presenter.view = view
                
        return view
    }
}
