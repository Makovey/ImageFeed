//
//  GradientView.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 14.10.2023.
//

import UIKit

final class GradientView: UIView {
    // MARK: - Dependencies

    let gradient = CAGradientLayer()
    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.insertSublayer(gradient, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = self.bounds
    }
    
    // MARK: - Public

    func configure(colors: [CGColor], locations: [NSNumber]) {
        gradient.colors = colors as [Any]
        gradient.locations = locations
    }
}
