//
//  ViewController.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 06.10.2023.
//

import UIKit

final class ImagesListViewController: UIViewController {
    private struct Constant {
        static let tableViewInset: CGFloat = 16.0
        static let cellInset: CGFloat = 4.0
    }
    
    // MARK: - Dependencies
    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .ypBlack
        tableView.register(ImagesListCell.self, forCellReuseIdentifier: ImagesListCell.reuseIdentifier)
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        
        setupUI()
    }
    
    // MARK: - Private
    private func setupUI() {
        tableView
            .placedOn(view)
            .pin(to: view, inset: Constant.tableViewInset)
    }
}

// MARK: - UITableViewDelegate
extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return .zero
        }
        
        let imageInsets = UIEdgeInsets(
            top: Constant.cellInset,
            left: Constant.tableViewInset,
            bottom: Constant.cellInset,
            right: Constant.tableViewInset
        )
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
    }
}

// MARK: - UITableViewDataSource
extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photosName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ImagesListCell.reuseIdentifier,
            for: indexPath
        ) as? ImagesListCell else { return UITableViewCell() }
        
        let isLiked = indexPath.row % 2 == 0
        cell.configureCell(with: photosName[indexPath.row], isLikeActive: isLiked)
        
        return cell
    }
}
