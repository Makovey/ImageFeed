//
//  ImagesListTests.swift
//  ImageFeedTests
//
//  Created by MAKOVEY Vladislav on 25.12.2023.
//

@testable import ImageFeed
import XCTest

final class ImagesListTests: XCTestCase {
    func test_presenterFetchPhotos_whenViewDidLoad() {
        // arrange
        let viewController = ImagesListViewController()
        let spyPresenter = ImagesListPresenterSpy()
        
        viewController.presenter = spyPresenter
        
        // act
        _ = viewController.view
        
        // assert
        XCTAssertTrue(spyPresenter.invokedFetchPhotos)
    }
    
    func test_presenterCallsRoutersSingleImage_whenTapOnPhoto() {
        // arrange
        let storage = OAuth2TokenStorage()
        let service = ImagesListService(storage: storage)
        let presenter = ImageListPresenter(imagesListService: service)
        let spyRouter = ImagesListRouterSpy()
        
        presenter.router = spyRouter
        
        let photoViewModel = PhotoViewModel(
            id: "1",
            size: .zero,
            createdAt: nil,
            welcomeDescription: nil,
            thumbImageUrl: "https://tested.unsplash.thumb.com",
            largeImageUrl: "https://tested.unsplash.large.com",
            isLiked: false
        )
        
        // act
        presenter.didPhotoTap(photoViewModel)
        
        // assert
        XCTAssertTrue(spyRouter.invokedOpenSingleImage)
    }
    
    func test_presenterCallsUpdateLikeState_whenGetsResponseFromService() {
        // arrange
        let service = ImagesListServiceStub()
        let presenter = ImageListPresenter(imagesListService: service)
        let spyViewController = ImagesListViewControllerSpy()
        
        presenter.view = spyViewController
        
        let photoId = "1"
        let needsToLike = false
        
        // act
        presenter.didTapLike(with: photoId, needsToLike: needsToLike)
        
        // assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(spyViewController.invokedUpdateLikeState)
        }
    }
}
