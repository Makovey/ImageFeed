//
//  WebViewTests.swift
//  ImageFeedTests
//
//  Created by MAKOVEY Vladislav on 22.12.2023.
//

@testable import ImageFeed
import XCTest

final class WebViewTests: XCTestCase {
    func test_presenterCallsViewDidLoad_whenViewDidLoad() {
        // arrange
        let viewController = WebViewViewController()
        let spyPresenter = WebViewPresenterSpy()
        
        viewController.presenter = spyPresenter
        
        // act
        _ = viewController.view
        
        // assert
        XCTAssertTrue(spyPresenter.invokedViewDidLoad)
    }
    
    func test_presenterCallsLoadRequest_whenViewDidLoad() {
        // arrange
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        let spyViewController = WebViewViewControllerSpy()
        
        presenter.view = spyViewController
        
        // act
        presenter.viewDidLoad()
        
        // assert
        XCTAssertTrue(spyViewController.invokedLoad)
    }
    
    func test_progressVisible_whenProgressLessThenOne() {
        // arrange
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        let progress: Float = 0.6
        
        // act
        let shouldHideProgress = presenter.shouldHideProgress(for: progress)
        
        // assert
        XCTAssertFalse(shouldHideProgress)
    }
    
    func test_progressHidden_whenProgressIsOne() {
        // arrange
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        let progress: Float = 1.0
        
        // act
        let shouldHideProgress = presenter.shouldHideProgress(for: progress)
        
        // assert
        XCTAssertTrue(shouldHideProgress)
    }
}
