//
//  OAuth2ServiceError.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 29.11.2023.
//

import Foundation

enum OAuth2ServiceError: Error {
    case noInternetConnectionError
    case serverError
    case emptyDataError
    case invalidParsingError
    case invalidUrlError
}
