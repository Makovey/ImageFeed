//
//  ServiceError.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 29.11.2023.
//

import Foundation

enum ServiceError: Error {
    case noInternetConnectionError
    case serverError
    case emptyDataError
    case serializeBodyError
    case invalidParsingError
    case invalidUrlError
}
