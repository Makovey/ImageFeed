//
//  SingleImageAssembly.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 29.10.2023.
//

import UIKit

final class SingleImageAssembly {
    static func assemble() -> SingleImageViewController {
        let view = SingleImageViewController()
        view.overrideUserInterfaceStyle = .dark
        return view
    }
}

