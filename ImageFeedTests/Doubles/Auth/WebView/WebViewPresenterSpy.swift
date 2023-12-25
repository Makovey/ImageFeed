//
//  WebViewPresenterSpy.swift
//  ImageFeedTests
//
//  Created by MAKOVEY Vladislav on 22.12.2023.
//

import Foundation
@testable import ImageFeed

final class WebViewPresenterSpy: IWebViewPresenter {
    
    var view: WebViewViewController?

    var invokedViewDidLoad = false
    var invokedViewDidLoadCount = 0

    func viewDidLoad() {
        invokedViewDidLoad = true
        invokedViewDidLoadCount += 1
    }

    var invokedDidUpdateProgressValue = false
    var invokedDidUpdateProgressValueCount = 0
    var invokedDidUpdateProgressValueParameters: (newValue: Double, Void)?
    var invokedDidUpdateProgressValueParametersList = [(newValue: Double, Void)]()

    func didUpdateProgressValue(_ newValue: Double) {
        invokedDidUpdateProgressValue = true
        invokedDidUpdateProgressValueCount += 1
        invokedDidUpdateProgressValueParameters = (newValue, ())
        invokedDidUpdateProgressValueParametersList.append((newValue, ()))
    }

    var invokedGetCode = false
    var invokedGetCodeCount = 0
    var invokedGetCodeParameters: (url: URL?, Void)?
    var invokedGetCodeParametersList = [(url: URL?, Void)]()
    var stubbedGetCodeResult: String!

    func getCode(from url: URL?) -> String? {
        invokedGetCode = true
        invokedGetCodeCount += 1
        invokedGetCodeParameters = (url, ())
        invokedGetCodeParametersList.append((url, ()))
        return stubbedGetCodeResult
    }
}
