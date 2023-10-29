//
//  ImagesListPresenter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 29.10.2023.
//

import Foundation

protocol IImageListPresenter {
    func didImageTapped(imageName: String)
}

final class ImageListPresenter: IImageListPresenter {
    
    // MARK: - Dependencies
    
    var router: IImageListRouter?
    
    func didImageTapped(imageName: String) {
        //
    }
}
