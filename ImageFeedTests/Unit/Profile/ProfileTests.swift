//
//  ProfileTests.swift
//  ImageFeedTests
//
//  Created by MAKOVEY Vladislav on 25.12.2023.
//

@testable import ImageFeed
import XCTest

final class ProfileTests: XCTestCase {
    private struct Constant {
        static let firstName = "TestFirstName"
        static let lastName = "TestLastName"
        static let username = "TestUsername"
        static let bio = "TestBio"
    }
    
    func test_presenterCallsViewDidLoad_whenViewDidLoad() {
        // arrange
        let viewController = ProfileViewController()
        let spyPresenter = ProfilePresenterSpy()
        
        viewController.presenter = spyPresenter
        
        // act
        _ = viewController.view
        
        // assert
        XCTAssertTrue(spyPresenter.invokedViewDidLoad)
    }
    
    func test_presenterCallRoutersLogout_whenExitButtonTapped() {
        // arrange
        let profileResult = ProfileResult(username: "usersName", firstName: "firstName", lastName: "lastName", bio: nil)
        let storage = OAuth2TokenStorage()
        
        let presenter = ProfilePresenter(profileData: profileResult, storage: storage)
        let spyRouter = ProfileRouterSpy()
        presenter.router = spyRouter
        
        // act
        presenter.exitButtonTapped()
        
        // assert
        XCTAssertTrue(spyRouter.invokedLogout)
    }
    
    func test_presenterMakeFilledViewModel_whenDataIsNotNil() throws {
        // arrange
        let profileResult = ProfileResult(
            username: Constant.username,
            firstName: Constant.firstName,
            lastName: Constant.lastName,
            bio: Constant.bio
        )
        
        let expectedViewModel = ProfileViewModel(
            username: profileResult.username,
            name: "\(profileResult.firstName!) \(profileResult.lastName!)",
            loginName: "@\(profileResult.username!)",
            bio: profileResult.bio
        )
        
        let storage = OAuth2TokenStorage()
        
        let presenter = ProfilePresenter(profileData: profileResult, storage: storage)
        let spyViewController = ProfileViewControllerSpy()
        presenter.view = spyViewController
        
        // act
        presenter.viewDidLoad()
        
        // assert
        let actualViewModel = try XCTUnwrap(spyViewController.invokedUpdateProfileDataParameters?.data)
        XCTAssertEqual(actualViewModel, expectedViewModel)
    }
    
    func test_presenterMakeEmptyViewModel_whenDataIsNil() throws {
        // arrange
        let profileResult = ProfileResult(
            username: nil,
            firstName: nil,
            lastName: nil,
            bio: nil
        )
        
        let expectedViewModel = ProfileViewModel(
            username: "",
            name: " ",
            loginName: "",
            bio: nil
        )
        
        let storage = OAuth2TokenStorage()
        
        let presenter = ProfilePresenter(profileData: profileResult, storage: storage)
        let spyViewController = ProfileViewControllerSpy()
        presenter.view = spyViewController
        
        // act
        presenter.viewDidLoad()
        
        // assert
        let actualViewModel = try XCTUnwrap(spyViewController.invokedUpdateProfileDataParameters?.data)
        XCTAssertEqual(actualViewModel, expectedViewModel)
    }
}
