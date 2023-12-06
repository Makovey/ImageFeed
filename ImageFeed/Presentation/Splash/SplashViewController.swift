//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 28.11.2023.
//

import ProgressHUD
import UIKit

protocol ISplashViewController {
    func showLoader()
    func dismissLoader()
    func showAlert(action: @escaping () -> Void)
}

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
        presenter?.loadData()
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
        vc.dismiss(animated: true)
        presenter?.didAuthenticated(with: code)
    }
}

// MARK: - ISplashViewController

extension SplashViewController: ISplashViewController {
    func showLoader() {
        UIBlockingProgressHUD.show()
    }
    
    func dismissLoader() {
        UIBlockingProgressHUD.dismiss()
    }
    
    func showAlert(action: @escaping () -> Void) {
        let alertViewController = UIAlertController(
            title: "splash.alert.title".localized,
            message: "splash.alert.subtitle".localized,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: "splash.alertButton.title".localized,
            style: .default,
            handler: { _ in action() }
        )

        alertViewController.addAction(action)
        present(alertViewController, animated: true)
    }
}
