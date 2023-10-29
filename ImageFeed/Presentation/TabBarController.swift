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
        let profile = assembleNavigationController(for: ProfileViewController(), image: .tabProfile)
        
        viewControllers = [imageList, profile]
    }
    
    private func assembleNavigationController(
        for viewController: UIViewController,
        image: UIImage
    ) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.title = title
        navigationController.tabBarItem.image = image
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
}
