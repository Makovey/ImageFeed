//
//  ImagesListPresenterSpy.swift
//  ImageFeedTests
//
//  Created by MAKOVEY Vladislav on 25.12.2023.
//

@testable import ImageFeed

final class ImagesListPresenterSpy: IImageListPresenter {

    var invokedDidPhotoTap = false
    var invokedDidPhotoTapCount = 0
    var invokedDidPhotoTapParameters: (photo: PhotoViewModel, Void)?
    var invokedDidPhotoTapParametersList = [(photo: PhotoViewModel, Void)]()

    func didPhotoTap(_ photo: PhotoViewModel) {
        invokedDidPhotoTap = true
        invokedDidPhotoTapCount += 1
        invokedDidPhotoTapParameters = (photo, ())
        invokedDidPhotoTapParametersList.append((photo, ()))
    }

    var invokedFetchPhotos = false
    var invokedFetchPhotosCount = 0

    func fetchPhotos() {
        invokedFetchPhotos = true
        invokedFetchPhotosCount += 1
    }

    var invokedDidTapLike = false
    var invokedDidTapLikeCount = 0
    var invokedDidTapLikeParameters: (photoId: String, needsToLike: Bool)?
    var invokedDidTapLikeParametersList = [(photoId: String, needsToLike: Bool)]()

    func didTapLike(with photoId: String, needsToLike: Bool) {
        invokedDidTapLike = true
        invokedDidTapLikeCount += 1
        invokedDidTapLikeParameters = (photoId, needsToLike)
        invokedDidTapLikeParametersList.append((photoId, needsToLike))
    }
}
