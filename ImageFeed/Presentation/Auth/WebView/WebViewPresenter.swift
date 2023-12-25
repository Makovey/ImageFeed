//
//  WebViewPresenter.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 26.11.2023.
//

import Foundation
import WebKit

protocol IWebViewPresenter {
    func viewDidLoad()
    func didUpdateProgressValue(_ newValue: Double)
    func getCode(from url: URL?) -> String?
}

final class WebViewPresenter: IWebViewPresenter {

    // MARK: - Dependencies
    
    weak var view: IWebViewViewController?
    private let authHelper: IAuthHelper
    
    // MARK: - Init
    
    init(authHelper: IAuthHelper) {
        self.authHelper = authHelper
    }
    
    func viewDidLoad() {
        didUpdateProgressValue(0)
        
        guard let request = authHelper.makeAuthRequest() else { return }
        view?.load(request: request)
    }
    
    func didUpdateProgressValue(_ newValue: Double) {
        let newProgressValue = Float(newValue)
        view?.setProgressValue(newProgressValue)

        let shouldHideProgress = shouldHideProgress(for: newProgressValue)
        view?.setProgressHidden(shouldHideProgress)
    }
    
    func getCode(from url: URL?) -> String? {
        guard let url else { return nil }
        return authHelper.code(from: url)
    }
    
    func shouldHideProgress(for value: Float) -> Bool {
        abs(value - 1.0) <= 0.0001
    }
}
