//
//  SingleImageAssembly.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 29.10.2023.
//

import UIKit

final class SingleImageAssembly {
    static func assemble(with url: URL) -> SingleImageViewController {
        let view = SingleImageViewController(mainImageUrl: url)
        view.overrideUserInterfaceStyle = .dark
        return view
    }
}

