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
    
    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.trackTintColor = .ypGray
        progress.progressTintColor = .ypBlack
        return progress.forAutolayout()
    }()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        
        setupUI()
        setupInitialState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            options: .new,
            context: nil
        )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        webView.removeObserver(
            self, forKeyPath:#keyPath(WKWebView.estimatedProgress),
            context: nil
        )
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        guard keyPath == #keyPath(WKWebView.estimatedProgress) else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        updateProgress()
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
        
        progressView.placedOn(view)
        NSLayoutConstraint.activate([
            progressView.top.constraint(equalTo: backButton.bottom),
            progressView.left.constraint(equalTo: view.left),
            progressView.right.constraint(equalTo: view.right)
        ])
    }
    
    private func setupInitialState() {
        guard let request = presenter?.makeUrlRequest() else { return }
        webView.load(request)
    }
    
    private func updateProgress() {
        progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        progressView.isHidden = fabs(webView.estimatedProgress - 1.0) <= 0.0001
    }
    
    @objc
    private func backButtonTapped() {
        delegate?.webViewViewControllerDidCancel(self)
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
        delegate?.webViewViewController(self, didAuthenticateWithCode: code)
        decisionHandler(.cancel)
    }
}
