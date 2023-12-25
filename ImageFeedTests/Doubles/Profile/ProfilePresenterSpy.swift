//
//  ProfilePresenterSpy.swift
//  ImageFeedTests
//
//  Created by MAKOVEY Vladislav on 25.12.2023.
//

@testable import ImageFeed

final class ProfilePresenterSpy: IProfilePresenter {

    var invokedViewDidLoad = false
    var invokedViewDidLoadCount = 0

    func viewDidLoad() {
        invokedViewDidLoad = true
        invokedViewDidLoadCount += 1
    }

    var invokedExitButtonTapped = false
    var invokedExitButtonTappedCount = 0

    func exitButtonTapped() {
        invokedExitButtonTapped = true
        invokedExitButtonTappedCount += 1
    }
}
