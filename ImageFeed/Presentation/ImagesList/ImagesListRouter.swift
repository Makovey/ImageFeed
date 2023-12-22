//
//  ImagesListRouter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 29.10.2023.
//

import UIKit

protocol IImageListRouter {
    func openSingleImage(with url: URL)
}

final class ImageListRouter: IImageListRouter {
    
    // MARK: - Dependencies

    weak var viewController: UIViewController?

    func openSingleImage(with url: URL) {
        let destination = SingleImageAssembly.assemble(with: url)
        destination.modalPresentationStyle = .fullScreen
        viewController?.present(destination, animated: true)
    }
}
