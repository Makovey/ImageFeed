//
//  ImagesListRouterSpy.swift
//  ImageFeedTests
//
//  Created by MAKOVEY Vladislav on 25.12.2023.
//

import Foundation
@testable import ImageFeed

final class ImagesListRouterSpy: IImageListRouter {

    var invokedOpenSingleImage = false
    var invokedOpenSingleImageCount = 0
    var invokedOpenSingleImageParameters: (url: URL, Void)?
    var invokedOpenSingleImageParametersList = [(url: URL, Void)]()

    func openSingleImage(with url: URL) {
        invokedOpenSingleImage = true
        invokedOpenSingleImageCount += 1
        invokedOpenSingleImageParameters = (url, ())
        invokedOpenSingleImageParametersList.append((url, ()))
    }
}
