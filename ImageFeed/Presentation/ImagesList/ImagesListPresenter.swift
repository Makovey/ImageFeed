//
//  ImagesListPresenter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 29.10.2023.
//

import UIKit

protocol IImageListPresenter {
    func didImageTapped(image: UIImage?)
}

final class ImageListPresenter: IImageListPresenter {
    
    // MARK: - Dependencies
    
    var router: IImageListRouter?
    
    func didImageTapped(image: UIImage?) {
        router?.openSingleImage(image: image)
    }
}
