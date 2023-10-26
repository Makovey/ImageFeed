//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 09.10.2023.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    
    private struct Constant {
        static let baseCornerRadius: CGFloat = 16.0
        static let distanceBetweenCell: CGFloat = 4.0
        static let gradientHeight: CGFloat = 30.0
        static let labelDistance: CGFloat = 8
    }
    
    // MARK: - Properties

    private var isLikeActive = false

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: - UI

    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypWhite
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    private lazy var gradientView: UIView = {
        let gradientView = GradientView()
        
        gradientView.clipsToBounds = true
        gradientView.layer.cornerRadius = Constant.baseCornerRadius
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        gradientView.configure(colors: [
            UIColor.ypBlack.withAlphaComponent(0).cgColor,
            UIColor.ypBlack.withAlphaComponent(0.2).cgColor
        ], locations: [0, 0.25])
        
        return gradientView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = Constant.baseCornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: .init(
            top: Constant.distanceBetweenCell,
            left: .zero,
            bottom: Constant.distanceBetweenCell,
            right: .zero
        ))
    }
    
    // MARK: - Configure methods

    func configureCell(with imageName: String, isLikeActive: Bool) {
        guard let image = UIImage(named: imageName) else { return }
        self.isLikeActive = isLikeActive
        
        mainImageView = .init(image: image)
        dateLabel.text = dateFormatter.string(from: Date())
        likeButton.setBackgroundImage(
            isLikeActive ? .activeLike : .disableLike,
            for: .normal
        )
        
        setupUI()
    }
    
    private func setupUI() {
        mainImageView
            .placedOn(contentView)
            .pin(to: contentView)
        
        likeButton.placedOn(contentView)
        NSLayoutConstraint.activate([
            likeButton.top.constraint(equalTo: contentView.top),
            likeButton.right.constraint(equalTo: contentView.right)
        ])
        
        gradientView.placedOn(contentView)
        NSLayoutConstraint.activate([
            gradientView.left.constraint(equalTo: contentView.left),
            gradientView.right.constraint(equalTo: contentView.right),
            gradientView.bottom.constraint(equalTo: contentView.bottom),
            gradientView.height.constraint(equalToConstant: Constant.gradientHeight)
        ])
        
        dateLabel.placedOn(contentView)
        NSLayoutConstraint.activate([
            dateLabel.left.constraint(equalTo: contentView.left, constant: Constant.labelDistance),
            dateLabel.bottom.constraint(equalTo: contentView.bottom, constant: -Constant.labelDistance)
        ])
    }
    
    @objc private func likeButtonPressed() {
        isLikeActive = !isLikeActive
        likeButton.setBackgroundImage(
            isLikeActive ? .activeLike : .disableLike,
            for: .normal
        )
    }
}
