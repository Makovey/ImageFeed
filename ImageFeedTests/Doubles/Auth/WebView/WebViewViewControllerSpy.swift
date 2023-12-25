//
//  WebViewViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by MAKOVEY Vladislav on 22.12.2023.
//

import Foundation
@testable import ImageFeed

final class WebViewViewControllerSpy: IWebViewViewController {

    var invokedLoad = false
    var invokedLoadCount = 0
    var invokedLoadParameters: (request: URLRequest, Void)?
    var invokedLoadParametersList = [(request: URLRequest, Void)]()

    func load(request: URLRequest) {
        invokedLoad = true
        invokedLoadCount += 1
        invokedLoadParameters = (request, ())
        invokedLoadParametersList.append((request, ()))
    }

    var invokedSetProgressValue = false
    var invokedSetProgressValueCount = 0
    var invokedSetProgressValueParameters: (newValue: Float, Void)?
    var invokedSetProgressValueParametersList = [(newValue: Float, Void)]()

    func setProgressValue(_ newValue: Float) {
        invokedSetProgressValue = true
        invokedSetProgressValueCount += 1
        invokedSetProgressValueParameters = (newValue, ())
        invokedSetProgressValueParametersList.append((newValue, ()))
    }

    var invokedSetProgressHidden = false
    var invokedSetProgressHiddenCount = 0
    var invokedSetProgressHiddenParameters: (isHidden: Bool, Void)?
    var invokedSetProgressHiddenParametersList = [(isHidden: Bool, Void)]()

    func setProgressHidden(_ isHidden: Bool) {
        invokedSetProgressHidden = true
        invokedSetProgressHiddenCount += 1
        invokedSetProgressHiddenParameters = (isHidden, ())
        invokedSetProgressHiddenParametersList.append((isHidden, ()))
    }
}
