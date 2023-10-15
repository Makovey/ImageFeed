//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 09.10.2023.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView(image: .init(named: "0"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "27 августа 2022"
        label.textColor = .ypWhite
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    private lazy var gradientView: UIView = {
        let gradientView = GradientView()
        
        gradientView.clipsToBounds = true
        gradientView.layer.cornerRadius = 16
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        gradientView.configure(colors: [
            UIColor.ypBlack.withAlphaComponent(0).cgColor,
            UIColor.ypBlack.withAlphaComponent(0.2).cgColor
        ], locations: [0, 0.25])
        
        return gradientView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.noActiveImage, for: .normal)
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Configure methods
    func setupCell() {
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
            gradientView.height.constraint(equalToConstant: 30)
        ])
        
        dateLabel.placedOn(contentView)
        NSLayoutConstraint.activate([
            dateLabel.left.constraint(equalTo: contentView.left, constant: 8),
            dateLabel.bottom.constraint(equalTo: contentView.bottom, constant: -8)
        ])
    }
    
    @objc func likeButtonPressed() {
        likeButton.setBackgroundImage(.activeImage, for: .normal)
    }
}
