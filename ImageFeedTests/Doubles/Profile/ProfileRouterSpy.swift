//
//  ProfileRouterSpy.swift
//  ImageFeedTests
//
//  Created by MAKOVEY Vladislav on 25.12.2023.
//

@testable import ImageFeed

final class ProfileRouterSpy: IProfileRouter {

    var invokedLogout = false
    var invokedLogoutCount = 0

    func logout() {
        invokedLogout = true
        invokedLogoutCount += 1
    }
}
