//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 24.10.2023.
//

import ProgressHUD
import UIKit

protocol IProfileViewController {
    func updateProfileData(data: ProfileViewModel)
    func showError(error: String)
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
        
        ProgressHUD.show()
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
}

extension ProfileViewController: IProfileViewController {
    func updateProfileData(data: ProfileViewModel) {
        ProgressHUD.dismiss()
        nameLabel.text = data.name
        loginNameLabel.text = data.loginName
        descriptionLabel.text = data.bio
    }
    
    func showError(error: String) {
        ProgressHUD.dismiss()
        // TODO: handle error
    }
}
