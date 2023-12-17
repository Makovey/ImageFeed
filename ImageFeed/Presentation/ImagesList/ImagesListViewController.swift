//
//  ViewController.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 06.10.2023.
//

import UIKit

protocol IImagesListViewController: AnyObject {
    func update(viewModels: [PhotoViewModel])
}

final class ImagesListViewController: UIViewController {
    private struct Constant {
        static let tableViewInset: CGFloat = 16.0
        static let cellInset: CGFloat = 4.0
        static let sizeOfNewPhotoBatch = 10
    }
    
    // MARK: - Dependencies

    var presenter: IImageListPresenter?

    private var photos = [PhotoViewModel]()
    private var currentImage: UIImage?
    
    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .ypBlack
        tableView.register(ImagesListCell.self, forCellReuseIdentifier: ImagesListCell.reuseIdentifier)
        return tableView
    }()

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        
        setupUI()
        presenter?.fetchPhotos()
    }
    
    // MARK: - Private

    private func setupUI() {
        tableView
            .placedOn(view)
            .pin(to: view, inset: Constant.tableViewInset)
    }
    
    private func updateTableViewAnimated() {
        let indexPaths = photos
            .suffix(Constant.sizeOfNewPhotoBatch)
            .indices
            .map { IndexPath(row: $0, section: .zero) }

        tableView.performBatchUpdates {
            tableView.beginUpdates()
            tableView.insertRows(at: indexPaths, with: .middle)
            tableView.endUpdates()
        }
    }
}

// MARK: - UITableViewDelegate

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let image = UIImage(named: mockPhotosName[indexPath.row])
//        presenter?.didImageTapped(image: image)
        // TODO: support dynamic images
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let photoModel = photos[safe: indexPath.row] else {
            return .zero
        }

        let imageInsets = UIEdgeInsets(
            top: Constant.cellInset,
            left: Constant.tableViewInset,
            bottom: Constant.cellInset,
            right: Constant.tableViewInset
        )

        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = photoModel.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = photoModel.size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        if indexPath.row + 1 == photos.count - 1 {
            presenter?.fetchPhotos()
        }
    }
}

// MARK: - UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ImagesListCell.reuseIdentifier,
            for: indexPath
        ) as? ImagesListCell else { return UITableViewCell() }
        
        cell.configureCell(with: photos[indexPath.row]) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - IImagesListViewController

extension ImagesListViewController: IImagesListViewController {
    func update(viewModels: [PhotoViewModel]) {
        photos.append(contentsOf: viewModels)
        updateTableViewAnimated()
    }
}
