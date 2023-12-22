//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 24.10.2023.
//

import Kingfisher
import UIKit

protocol IProfileViewController: AnyObject {
    func updateProfileData(data: ProfileViewModel)
    func updateAvatar(with url: URL)
}

final class ProfileViewController: UIViewController {
    private struct Constant {
        static let baseInset: CGFloat = 16.0
        static let baseSpacing: CGFloat = 8.0
        static let imageSize: CGFloat = 70.0
    }
    
    // MARK: - Properties
    
    var presenter: IProfilePresenter?
    
    // MARK: - UI
    
    private lazy var profileView: UIImageView = {
        let imageView = UIImageView(image: .stubUserImage)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.masksToBounds = true
        return imageView.forAutolayout()
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setImage(.exitImage, for: .normal)
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileView, exitButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textColor = .ypWhite
        return label
    }()
    private lazy var loginNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .ypGray
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .ypWhite
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, loginNameLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = Constant.baseSpacing
        return stackView
    }()

    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        
        setupUI()
        presenter?.viewDidLoad()
    }

    // MARK: - Private
    
    private func setupUI() {
        setupProfileStack()
        setupInfoStack()
    }
    
    private func setupProfileStack() {
        profileStackView
            .placedOn(view)
        
        NSLayoutConstraint.activate([
            profileStackView.top.constraint(equalTo: view.safeTop, constant: Constant.baseInset * 2),
            profileStackView.left.constraint(equalTo: view.left, constant: Constant.baseInset),
            profileStackView.right.constraint(equalTo: view.right, constant: -Constant.baseInset),
        ])
        
        NSLayoutConstraint.activate([
            profileView.width.constraint(equalToConstant: Constant.imageSize),
            profileView.height.constraint(equalToConstant: Constant.imageSize)
        ])
    }
    
    private func setupInfoStack() {
        infoStackView
            .placedOn(view)
        
        NSLayoutConstraint.activate([
            infoStackView.top.constraint(equalTo: profileStackView.bottom, constant: Constant.baseInset / 2),
            infoStackView.left.constraint(equalTo: view.left, constant: Constant.baseInset),
            infoStackView.right.constraint(equalTo: view.right, constant: -Constant.baseInset)
        ])
    }
    
    @objc
    private func exitButtonTapped() {
        showAlert()
    }
    
    private func showAlert() {
        let alertViewController = UIAlertController(
            title: "profile.alert.title".localized,
            message: "profile.alert.subtitle".localized,
            preferredStyle: .alert
        )
        
        let yesAction = UIAlertAction(
            title: "profile.alertButton.yes.title".localized,
            style: .default,
            handler: { _ in
                self.presenter?.exitButtonTapped()
            }
        )
        
        let noAction = UIAlertAction(
            title: "profile.alertButton.no.title".localized,
            style: .default
        )

        alertViewController.addAction(yesAction)
        alertViewController.addAction(noAction)
        present(alertViewController, animated: true)
    }
}

// MARK: - IProfileViewController

extension ProfileViewController: IProfileViewController {
    func updateProfileData(data: ProfileViewModel) {
        nameLabel.text = data.name
        loginNameLabel.text = data.loginName
        descriptionLabel.text = data.bio
    }
    
    func updateAvatar(with url: URL) {
        profileView.kf.indicatorType = .activity
        profileView.kf.setImage(with: url)
    }
}
