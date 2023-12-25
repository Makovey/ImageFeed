//
//  ImageFeedUITests.swift
//  ImageFeedUITests
//
//  Created by MAKOVEY Vladislav on 25.12.2023.
//

import XCTest

final class ImageFeedUITests: XCTestCase {
    private struct Constant {
        static let entryButton = "Authenticate"
        static let webView = "UnsplashWebView"
        static let loginButton = "Login"
        static let toolbarKeyboardButton = "Готово"
        
        static let email = "twomvlad@mail.ru" // TODO: - type your email
        static let password = "HardPass123" // TODO: - type your password
        
        static let likeButton = "LikeButton"
        static let singleImageBackButton = "SingleImageBackButton"
        
        static let profileName = "Vladislav Makovey" // TODO: - type your profile name
        static let username = "@makovej" // TODO: - type your username
        static let bio = "testable bio" // TODO: - type your bio
        
        static let exitButton = "ExitButton"
        static let profileAlert = "ProfileAlert"
    }
    private let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testAuth() {
        app.buttons[Constant.entryButton].tap()
        
        let webView = app.webViews[Constant.webView]
        XCTAssertTrue(webView.waitForExistence(timeout: 5))

        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(webView.waitForExistence(timeout: 5))

        loginTextField.tap()
        loginTextField.typeText(Constant.email)
        app.toolbars.buttons[Constant.toolbarKeyboardButton].tap()
        
        let secureTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(webView.waitForExistence(timeout: 5))

        secureTextField.tap()
        secureTextField.typeText(Constant.password)
        app.toolbars.buttons[Constant.toolbarKeyboardButton].tap()

        webView.buttons[Constant.loginButton].tap()

        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
    }
    
    func testFeed() {
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
        cell.swipeUp()
        
        sleep(2)
        
        let newCell = tablesQuery.children(matching: .cell).element(boundBy: 2)
        newCell.buttons[Constant.likeButton].tap()
        sleep(3)
        newCell.buttons[Constant.likeButton].tap()
        
        newCell.tap()

        let image = app.scrollViews.images.element(boundBy: 0)
        XCTAssertTrue(image.waitForExistence(timeout: 5))
        
        image.pinch(withScale: 3, velocity: 1)
        image.pinch(withScale: 0.5, velocity: -1)
        app.buttons[Constant.singleImageBackButton].tap()
    }
    
    func testProfile() {
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
        
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        XCTAssertTrue(app.staticTexts[Constant.profileName].exists)
        XCTAssertTrue(app.staticTexts[Constant.username].exists)
        XCTAssertTrue(app.staticTexts[Constant.bio].exists)
        
        app.buttons[Constant.exitButton].tap()
        
        let alert = app.alerts[Constant.profileAlert]
        XCTAssertTrue(alert.exists)

        alert.buttons.firstMatch.tap()
        
        let loginButton = app.buttons[Constant.entryButton]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 5))
    }
}
