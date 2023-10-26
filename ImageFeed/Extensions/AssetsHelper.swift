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
    static let noActiveImage = UIImage(named: "NoActive") ?? .init()
    static let activeImage = UIImage(named: "Active") ?? .init()
    static let exitImage = UIImage(named: "Exit") ?? .init()
    static let stubUserImage = UIImage(named: "StubUserImage") ?? .init()
}
