//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 27.11.2023.
//

import Foundation
import SwiftKeychainWrapper

protocol IOAuth2TokenStorage {
    var token: String? { get set }
    func removeToken()
}

struct OAuth2TokenStorage: IOAuth2TokenStorage {
    private struct Constant {
        static let bearerToken = "bearerToken"
    }
    
    // MARK: - Properties
    
    private let keychain = KeychainWrapper.standard
    
    var token: String? {
        get {
            keychain.string(forKey: Constant.bearerToken)
        }
        set {
            guard let newValue else { return }
            keychain.set(newValue, forKey: Constant.bearerToken)
        }
    }
    
    func removeToken() {
        keychain.removeObject(forKey: Constant.bearerToken)
    }
}
