//
//  WebViewViewController.swift
//  ImageFeed
//
//  Created by MAKOVEY Vladislav on 26.11.2023.
//

import WebKit
import UIKit

protocol IWebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}

final class WebViewViewController: UIViewController {
    private struct Constant {
        static let topButtonSpacing: CGFloat = 12.0
        static let baseInset: CGFloat = 8.0
    }
    
    // MARK: - Properties
    
    var presenter: IWebViewPresenter?
    weak var delegate: IWebViewViewControllerDelegate?

    // MARK: - UI
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.backgroundColor = .ypWhite
        webView.navigationDelegate = self
        return webView.forAutolayout()
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.backwardBlackArrow, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        
        setupUI()
        setupInitialState()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        webView
            .placedOn(view)
            .pin(to: view)
        
        backButton.placedOn(view)
        NSLayoutConstraint.activate([
            backButton.left.constraint(equalTo: view.left, constant: Constant.baseInset),
            backButton.top.constraint(equalTo: view.safeTop, constant: Constant.topButtonSpacing)
        ])
    }
    
    private func setupInitialState() {
        guard let request = presenter?.makeUrlRequest() else { return }
        webView.load(request)
    }
    
    @objc
    private func backButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - WKNavigationDelegate

extension WebViewViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        guard let code = presenter?.getCode(from: navigationAction) else {
            decisionHandler(.allow)
            return
        }

        decisionHandler(.cancel)
    }
}
