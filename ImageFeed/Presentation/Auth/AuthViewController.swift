//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 24.11.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    private struct Constant {
        static let basicCornerRadius: CGFloat = 16
        static let basicInset: CGFloat = 16
        static let bottomButtonInset: CGFloat = 90
        
        static let buttonHeight: CGFloat = 48
        static let fontButton: CGFloat = 17
    }
    
    // MARK: - Properties
    
    var presenter: IAuthPresenter?
    
    // MARK: - UI

    private lazy var mainImage: UIImageView = {
        UIImageView(image: .authScreenImage).forAutolayout()
    }()
    
    private lazy var entryButton: UIButton = {
        let button = UIButton().forAutolayout()
        
        button.setTitle("auth.button.title".localized, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constant.fontButton, weight: .bold)
        button.setTitleColor(.ypBlack, for: .normal)
        
        button.layer.cornerRadius = Constant.basicCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .ypWhite
        
        button.addTarget(self, action: #selector(entryButtonTapped), for: .touchUpInside)

        return button
    }()
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack

        setupUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - Private

    private func setupUI() {
        mainImage.placedOn(view)
        NSLayoutConstraint.activate([
            mainImage.centerX.constraint(equalTo: view.centerX),
            mainImage.centerY.constraint(equalTo: view.centerY)
        ])
        
        entryButton.placedOn(view)
        NSLayoutConstraint.activate([
            entryButton.height.constraint(equalToConstant: Constant.buttonHeight),
            entryButton.left.constraint(equalTo: view.left, constant: Constant.basicInset),
            entryButton.right.constraint(equalTo: view.right, constant: -Constant.basicInset),
            entryButton.bottom.constraint(equalTo: view.safeBottom, constant: -Constant.bottomButtonInset)
        ])
    }
    
    @objc
    private func entryButtonTapped() {
        presenter?.didLoginButtonTapped()
    }
}

// MARK: - WebViewViewControllerDelegate

extension AuthViewController: IWebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        vc.dismiss(animated: true)
        presenter?.didAuthenticated(with: code)
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        vc.dismiss(animated: true)
    }
}
