//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 27.11.2023.
//

import Foundation

protocol IOAuth2TokenStorage {
    var token: String? { get set }
}

struct OAuth2TokenStorage: IOAuth2TokenStorage {
    private struct Constant {
        static let bearerToken = "bearerToken"
    }
    
    // MARK: - Properties
    
    private let userDefaults = UserDefaults.standard
    
    var token: String? {
        get {
            userDefaults.string(forKey: Constant.bearerToken)
        }
        set {
            userDefaults.set(newValue, forKey: Constant.bearerToken)
        }
    }
}
