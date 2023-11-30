//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 28.11.2023.
//

import ProgressHUD
import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: ISplashPresenter?
    
    // MARK: - UI
    
    private lazy var image: UIImageView = {
        UIImageView(image: .launchLogo).forAutolayout()
    }()
    
    // MARK: - Overrides

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupUI()
        presenter?.checkUserAuth()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - Private
    
    private func setupUI() {
        image.placedOn(view)
        
        NSLayoutConstraint.activate([
            image.centerX.constraint(equalTo: view.centerX),
            image.centerY.constraint(equalTo: view.centerY)
        ])
    }
}

// MARK: - IAuthViewControllerDelegate

extension SplashViewController: IAuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        UIBlockingProgressHUD.show()
        presenter?.didAuthenticated(with: code) {
            UIBlockingProgressHUD.dismiss()
            vc.dismiss(animated: true)
        }
    }
}
