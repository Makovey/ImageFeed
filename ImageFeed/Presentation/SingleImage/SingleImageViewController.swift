//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 29.10.2023.
//

import UIKit

final class SingleImageViewController: UIViewController {
    private struct Constant {
        static let topButtonSpacing: CGFloat = 12.0
        static let baseInset: CGFloat = 8.0
    }
    
    // MARK: - Dependencies
    
    var mainImage: UIImage?
    
    // MARK: - UI
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.backwardArrow, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        
        setupUI()
    }

    
    // MARK: - Private
    
    private func setupUI() {
        imageView.image = mainImage
        imageView
            .placedOn(view)
            .pin(to: view)
        
        backButton
            .placedOn(view)
        
        NSLayoutConstraint.activate([
            backButton.left.constraint(equalTo: view.left, constant: Constant.baseInset),
            backButton.top.constraint(equalTo: view.top, constant: Constant.topButtonSpacing)
        ])
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
}
