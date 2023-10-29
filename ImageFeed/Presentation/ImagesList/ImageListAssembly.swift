//
//  ImageListAssembly.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 29.10.2023.
//

import UIKit

final class ImageListAssembly {
    static func assemble() -> UIViewController {
        let view = ImagesListViewController()
        let router = ImageListRouter()
        let presenter = ImageListPresenter()
        
        view.presenter = presenter
        presenter.router = router
        router.viewController = view
        
        return view
    }
}
