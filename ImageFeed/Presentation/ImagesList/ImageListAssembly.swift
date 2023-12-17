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
        
        let storage: IOAuth2TokenStorage = OAuth2TokenStorage()
        let imagesListService = ImagesListService(storage: storage)
        let presenter = ImageListPresenter(imagesListService: imagesListService)
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        router.viewController = view
        
        return view
    }
}
