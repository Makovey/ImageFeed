//
//  ImagesListViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by MAKOVEY Vladislav on 25.12.2023.
//

@testable import ImageFeed

final class ImagesListViewControllerSpy: IImagesListViewController {

    var invokedUpdate = false
    var invokedUpdateCount = 0
    var invokedUpdateParameters: (viewModels: [PhotoViewModel], Void)?
    var invokedUpdateParametersList = [(viewModels: [PhotoViewModel], Void)]()

    func update(viewModels: [PhotoViewModel]) {
        invokedUpdate = true
        invokedUpdateCount += 1
        invokedUpdateParameters = (viewModels, ())
        invokedUpdateParametersList.append((viewModels, ()))
    }

    var invokedUpdateLikeState = false
    var invokedUpdateLikeStateCount = 0
    var invokedUpdateLikeStateParameters: (photoId: String, Void)?
    var invokedUpdateLikeStateParametersList = [(photoId: String, Void)]()

    func updateLikeState(on photoId: String) {
        invokedUpdateLikeState = true
        invokedUpdateLikeStateCount += 1
        invokedUpdateLikeStateParameters = (photoId, ())
        invokedUpdateLikeStateParametersList.append((photoId, ()))
    }
}

