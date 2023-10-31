//
//  ImagesListRouter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 29.10.2023.
//

import UIKit

protocol IImageListRouter {
    func openSingleImage(image: UIImage?)
}

final class ImageListRouter: IImageListRouter {
    
    // MARK: - Dependencies

    weak var viewController: UIViewController?

    func openSingleImage(image: UIImage?) {
        let destination = SingleImageAssembly.assemble()
        destination.mainImage = image
        destination.modalPresentationStyle = .fullScreen
        viewController?.present(destination, animated: true)
    }
}
