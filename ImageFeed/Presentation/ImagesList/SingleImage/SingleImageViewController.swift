//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 29.10.2023.
//

import Kingfisher
import UIKit

final class SingleImageViewController: UIViewController {
    private struct Constant {
        static let topButtonSpacing: CGFloat = 12.0
        static let shareButtonSpacing: CGFloat = 16.0
        static let baseInset: CGFloat = 8.0
        
        static let minimumZoomScale = 0.1
        static let maximumZoomScale = 1.25
    }
    
    // MARK: - Dependencies
    
    private let mainImageUrl: URL
    
    // MARK: - UI
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.minimumZoomScale = Constant.minimumZoomScale
        scrollView.maximumZoomScale = Constant.maximumZoomScale
        return scrollView
    }()
    
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
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(.sharing, for: .normal)
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(mainImageUrl: URL) {
        self.mainImageUrl = mainImageUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        
        setupUI()
        setupInitialState()
    }

    
    // MARK: - Private
    
    private func setupUI() {
        scrollView
            .placedOn(view)
            .pin(to: view)

        imageView
            .placedOn(scrollView)
            .pin(to: scrollView)
                
        backButton
            .placedOn(view)
        
        NSLayoutConstraint.activate([
            backButton.left.constraint(equalTo: view.left, constant: Constant.baseInset),
            backButton.top.constraint(equalTo: view.safeTop, constant: Constant.topButtonSpacing)
        ])
        
        shareButton
            .placedOn(view)

        NSLayoutConstraint.activate([
            shareButton.centerX.constraint(equalTo: view.centerX),
            shareButton.bottom.constraint(equalTo: view.safeBottom, constant: -Constant.shareButtonSpacing)
        ])
    }
    
    private func setupInitialState() {
        UIBlockingProgressHUD.show()
        
        imageView.kf.setImage(with: mainImageUrl) { [weak self] result in
            UIBlockingProgressHUD.dismiss()
            
            switch result {
            case let .success(imageResult):
                self?.rescaleAndCenterImageInScrollView(image: imageResult.image)
            case .failure:
                self?.showErrorAlert()
            }
        }
        
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func shareButtonTapped() {
        guard let image = imageView.image else { return }
        let share = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        present(share, animated: true)
    }
    
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, max(hScale, vScale)))
        
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        
        let newContentSize = scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
    
    private func showErrorAlert() {
        let alertViewController = UIAlertController(
            title: "singleImage.alert.title".localized,
            message: nil,
            preferredStyle: .alert
        )
        
        let noNeedAction = UIAlertAction(
            title: "singleImage.alertButton.noNeed.title".localized,
            style: .default,
            handler: { _ in self.dismiss(animated: true) }
        )
        
        let retryAction = UIAlertAction(
            title: "singleImage.alertButton.retry.title".localized,
            style: .default,
            handler: { _ in self.setupInitialState() }
        )

        alertViewController.addAction(noNeedAction)
        alertViewController.addAction(retryAction)
        present(alertViewController, animated: true)
    }
}

// MARK: - UIScrollViewDelegate

extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
