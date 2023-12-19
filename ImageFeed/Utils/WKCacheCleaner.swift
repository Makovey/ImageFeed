//
//  WKCacheCleaner.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 18.12.2023.
//

import Foundation
import WebKit

struct WKCacheCleaner {
    static func clean() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach {
                WKWebsiteDataStore.default().removeData(ofTypes: $0.dataTypes, for: [$0], completionHandler: {})
            }
        }
    }
}

