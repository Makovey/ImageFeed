//
//  ImagesListServiceStub.swift
//  ImageFeedTests
//
//  Created by MAKOVEY Vladislav on 25.12.2023.
//

import Foundation
@testable import ImageFeed

final class ImagesListServiceStub: IImagesListService {

    func fetchPhotoNextPage(completion: @escaping (Result<[PhotoResult], ServiceError>) -> Void) {}

    func changeLike(photoId: String, needsToLike: Bool, completion: @escaping (Result<Empty, ServiceError>) -> Void) {
        completion(.success(.init()))
    }
}
