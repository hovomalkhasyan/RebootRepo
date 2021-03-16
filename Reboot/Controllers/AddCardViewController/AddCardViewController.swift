//
//  AddCardViewController.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 16.03.21.
//


import UIKit
import WebKit

protocol PaymentDelegate: class {
    func paymentSucced()
    func paymentFailed()
}

class AddCardViewController: UIViewController {

    // MARK: - Views
    private var containerView: UIView!
    private var topView: UIView!
    private var webView: WKWebView!

    // MARK: - Properties
//    var addCardResponseModel: AddCardResponseModel?
    weak var paymentDelegate: PaymentDelegate?
        
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        let url = URL(string: "https://reboot.ru/pricing")
        webView.load(URLRequest(url: url!))
    }

    @objc func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddCardViewController {
    private func setupUI() {
        addContainerView()
        addMapView()

        navigationController?.navigationBar.isTranslucent = false
    }

    // MARK: Table view
    func addContainerView() {
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)

        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(topView)

        topView.backgroundColor = .white

        topView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        let closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(closeButton)

        closeButton.setImage(UIImage(named: "back-arrow-1"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeAction(_:)), for: .touchUpInside)
        closeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        closeButton.imageView?.contentMode = .scaleAspectFit

        closeButton.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        closeButton.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 20).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    // MARK: Add payment method button
    func addMapView() {
        webView = WKWebView(frame: self.view.frame)
        webView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(webView)

        webView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true

        webView.navigationDelegate = self
        webView.uiDelegate = self
    }
}

extension AddCardViewController: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }

    private func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("finish to load")
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        if let fURL = navigationAction.request.url {
            let failedSufix = "failed"
            let successSufix = "success"

            if fURL.absoluteString.contains(successSufix) {
                DispatchQueue.main.async { [weak self] in
                    self?.addWhiteView()
                }
                self.paymentDelegate?.paymentSucced()
                decisionHandler(.allow)
            } else if fURL.absoluteString.contains(failedSufix) {
                self.paymentDelegate?.paymentFailed()
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
    }

    private func addWhiteView() {
        let whiteView = UIView()
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(whiteView)

        whiteView.backgroundColor = .white

        whiteView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        whiteView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        whiteView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        whiteView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
}

