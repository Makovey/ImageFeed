//
//  AuthHelperTests.swift
//  ImageFeedTests
//
//  Created by MAKOVEY Vladislav on 23.12.2023.
//

@testable import ImageFeed
import XCTest

final class AuthHelperTests: XCTestCase {
    private struct Constant {
        static let testUrl = "https://unsplash.com/oauth/authorize/native"
        static let code = "code"
        static let codeValue = "test code"
    }
    
    func test_makeAuthRequest() throws {
        // arrange
        let configuration = AuthConfiguration.standart
        let authHelper = AuthHelper(configuration: configuration)
        
        // act
        let request = authHelper.makeAuthRequest()
        let urlString = request?.url?.absoluteString
        let safetyUrl = try XCTUnwrap(urlString)
        
        // assert
        XCTAssertTrue(safetyUrl.contains(configuration.authorizeUrl))
        XCTAssertTrue(safetyUrl.contains(configuration.accessKey))
        XCTAssertTrue(safetyUrl.contains(configuration.redirectUri))
        XCTAssertTrue(safetyUrl.contains(Constant.code))
        XCTAssertTrue(safetyUrl.contains(configuration.accessScope))
    }
    
    func test_extractValidCodeFromUrl() throws {
        // arrange
        let authHelper = AuthHelper()

        var urlComponent = URLComponents(string: Constant.testUrl)
        urlComponent?.queryItems = [.init(name: Constant.code, value: Constant.codeValue)]
        let url = try XCTUnwrap(urlComponent?.url)
        
        // act
        let actualCode = authHelper.code(from: url)
        
        // assert
        XCTAssertEqual(actualCode, Constant.codeValue)
    }
}
