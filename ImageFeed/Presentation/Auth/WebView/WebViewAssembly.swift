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
        let presenter = WebViewPresenter()

        view.presenter = presenter
        view.delegate = delegate
        
        return view
    }
}
