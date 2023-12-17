//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 09.12.2023.
//

import Foundation

protocol IImagesListService {
    func fetchPhotoNextPage(completion: @escaping (Result<[PhotoResult], ServiceError>) -> Void)
}

final class ImagesListService: IImagesListService {
    private struct Constant {
        static let photosEndpoint = "/photos"
        static let page = "page"
        static let perPage = "per_page"
        static let photosPerPage = 10
        
        static let imagesListNotificationName = "ImagesListServiceDidChange"
    }
    
    // MARK: - Properties
    
    private let storage: IOAuth2TokenStorage
    private var task: URLSessionTask?
    private var lastLoadedPage = 0
    
    // MARK: - Init
    
    init(storage: IOAuth2TokenStorage) {
        self.storage = storage
    }
    
    // MARK: - IImagesListService
    
    func fetchPhotoNextPage(completion: @escaping (Result<[PhotoResult], ServiceError>) -> Void) {
        guard task == nil else { return }
        let nextPage = lastLoadedPage != 0 ? lastLoadedPage + 1 : 1
        
        var performer = RequestPerformer(
            url: AppConstant.defaultBaseURL + Constant.photosEndpoint,
            method: .getMethod,
            token: storage.token
        )
        
        performer.pathParams = [
            .init(name: Constant.page, value: "\(nextPage)"),
            .init(name: Constant.perPage, value: "\(Constant.photosPerPage)")
        ]
        
        task = performer.perform { (result: Result<[PhotoResult], ServiceError>) in
            self.task = nil
            switch result {
            case .success:
                self.lastLoadedPage += 1
            case .failure: break
            }
            completion(result)
        }
    }
}
