//
//  ViewController.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 06.10.2023.
//

import UIKit

protocol IImagesListViewController: AnyObject {
    func update(viewModels: [PhotoViewModel])
    func updateLikeState(on photoId: String)
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
        let photo = photos[indexPath.row]
        presenter?.didPhotoTap(photo)
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
        
        cell.delegate = self
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
    
    func updateLikeState(on photoId: String) {
        guard let index = photos.firstIndex(where: { $0.id == photoId }) else { return }
        let photo = photos[index]
        let newPhoto = PhotoViewModel(
            id: photo.id,
            size: photo.size,
            createdAt: photo.createdAt,
            welcomeDescription: photo.welcomeDescription,
            thumbImageUrl: photo.thumbImageUrl,
            largeImageUrl: photo.largeImageUrl,
            isLiked: !photo.isLiked
        )
        
        photos[index] = newPhoto
        
        guard let cell = tableView.cellForRow(at: .init(row: index, section: .zero)) as? ImagesListCell else {
            return
        }
        
        cell.setIsLiked(isLiked: newPhoto.isLiked)
        UIBlockingProgressHUD.dismiss()
    }
}

// MARK: - ImagesListCellDelegate

extension ImagesListViewController: ImagesListCellDelegate {
    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let photo = photos[indexPath.row]
        UIBlockingProgressHUD.show()
        presenter?.didTapLike(with: photo.id, needsToLike: !photo.isLiked)
    }
}
