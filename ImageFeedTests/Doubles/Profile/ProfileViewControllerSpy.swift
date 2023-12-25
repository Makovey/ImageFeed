//
//  ProfileViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by MAKOVEY Vladislav on 25.12.2023.
//

import Foundation
@testable import ImageFeed

final class ProfileViewControllerSpy: IProfileViewController {

    var invokedUpdateProfileData = false
    var invokedUpdateProfileDataCount = 0
    var invokedUpdateProfileDataParameters: (data: ProfileViewModel, Void)?
    var invokedUpdateProfileDataParametersList = [(data: ProfileViewModel, Void)]()

    func updateProfileData(data: ProfileViewModel) {
        invokedUpdateProfileData = true
        invokedUpdateProfileDataCount += 1
        invokedUpdateProfileDataParameters = (data, ())
        invokedUpdateProfileDataParametersList.append((data, ()))
    }

    var invokedUpdateAvatar = false
    var invokedUpdateAvatarCount = 0
    var invokedUpdateAvatarParameters: (url: URL, Void)?
    var invokedUpdateAvatarParametersList = [(url: URL, Void)]()

    func updateAvatar(with url: URL) {
        invokedUpdateAvatar = true
        invokedUpdateAvatarCount += 1
        invokedUpdateAvatarParameters = (url, ())
        invokedUpdateAvatarParametersList.append((url, ()))
    }
}
