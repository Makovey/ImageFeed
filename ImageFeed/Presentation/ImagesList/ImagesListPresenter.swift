//
//  ImagesListPresenter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 29.10.2023.
//

import UIKit

protocol IImageListPresenter {
    func didPhotoTap(_ photo: PhotoViewModel)
    func fetchPhotos()
    func didTapLike(with photoId: String, needsToLike: Bool)
}

final class ImageListPresenter: IImageListPresenter {
    
    // MARK: - Dependencies
    
    var router: IImageListRouter?
    weak var view: IImagesListViewController?
    
    private let imagesListService: IImagesListService
    
    // MARK: - Init
    
    init(imagesListService: IImagesListService) {
        self.imagesListService = imagesListService
    }
    
    // MARK: - IImageListPresenter
    
    func didPhotoTap(_ photo: PhotoViewModel) {
        guard let url = URL(string: photo.largeImageUrl) else { return }
        router?.openSingleImage(with: url)
    }
    
    func fetchPhotos() {
        imagesListService.fetchPhotoNextPage { [weak self] result in
            switch result {
            case let .success(photoModels):
                let viewModels = photoModels.map {
                    PhotoViewModel(
                        id: $0.id,
                        size: .init(width: $0.width, height: $0.height),
                        createdAt: $0.createdAt,
                        welcomeDescription: $0.description,
                        thumbImageUrl: $0.urls.thumb,
                        largeImageUrl: $0.urls.full,
                        isLiked: $0.likedByUser
                    )
                }

                DispatchQueue.main.async {
                    self?.view?.update(viewModels: viewModels)
                }
            case .failure:
                break // TODO: error handling
            }
        }
    }
    
    func didTapLike(with photoId: String, needsToLike: Bool) {
        imagesListService.changeLike(photoId: photoId, needsToLike: needsToLike) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.view?.updateLikeState(on: photoId)
                }
            case .failure:
                break // TODO: error handling
            }
        }
    }
}
