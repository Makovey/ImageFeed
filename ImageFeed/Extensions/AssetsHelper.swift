//
//  AssetsHelper.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 09.10.2023.
//

import UIKit

extension UIColor {
    static let ypBlack = UIColor(named: "YPBlack") ?? .clear
    static let ypWhite = UIColor(named: "YPWhite") ?? .clear
    static let ypGray = UIColor(named: "YPGray") ?? .clear
}

extension UIImage {
    static let disableLike = UIImage(named: "DisableLike") ?? .init()
    static let activeLike = UIImage(named: "ActiveLike") ?? .init()
    static let exitImage = UIImage(named: "Exit") ?? .init()
    static let stubUserImage = UIImage(named: "StubUserImage") ?? .init()
    static let tabImageList = UIImage(named: "TabImageListActive") ?? .init()
    static let tabProfile = UIImage(named: "TabProfileActive") ?? .init()
    static let backwardArrow = UIImage(named: "BackwardArrow") ?? .init()
    static let backwardBlackArrow = UIImage(named: "BackwardBlackArrow") ?? .init()
    static let sharing = UIImage(named: "Sharing") ?? .init()
    static let authScreenImage  = UIImage(named: "AuthImage") ?? .init()
    static let launchLogo  = UIImage(named: "LaunchLogo") ?? .init()
}
