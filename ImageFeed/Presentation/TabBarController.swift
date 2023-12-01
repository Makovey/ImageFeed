//
//  TabBarController.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 26.10.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .ypBlack
        tabBar.standardAppearance = appearance
        tabBar.tintColor = .ypWhite
        
        setupViewControllers()
    }
    
    // MARK: = Private
    
    private func setupViewControllers() {
        let imageList = assembleNavigationController(for: ImageListAssembly.assemble(), image: .tabImageList)
        let profile = assembleNavigationController(for: ProfileAssembly.assemble(), image: .tabProfile)
        
        viewControllers = [imageList, profile]
    }
    
    private func assembleNavigationController(
        for viewController: UIViewController,
        image: UIImage
    ) -> UIViewController {
        viewController.title = title
        viewController.tabBarItem.image = image
        viewController.overrideUserInterfaceStyle = .dark
        return viewController
    }
}
