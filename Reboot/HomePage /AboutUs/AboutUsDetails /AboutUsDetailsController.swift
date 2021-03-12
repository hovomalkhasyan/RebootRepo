//
//  AboutUsDetailsController.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 08.02.21.
//

import UIKit
import WebKit
class AboutUsDetailsController: BaseViewController {
    //MARK:- IBOutlets
    private var webView: WKWebView!
    @IBOutlet weak private var backButton: UIButton!
    
    //MARK: - propertyes
    var webViewUrl: String?
    
    //MARK: - LifeSycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGest()
        workoutsCount()
        setupInfoBtn()
        setupPageGesture()
        setbarView()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.hideNavBar()
    }
    
    //MARK: - backBtnAction
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - setupUrlWebView
extension AboutUsDetailsController {
    private func setup() {
        let configuration = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        let js = "localStorage.setItem('token', '\(UserDefaults.standard.value(forKey: "token")!)')"
        let userScript = WKUserScript(source: js, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: false)
        contentController.addUserScript(userScript)
        configuration.userContentController = contentController

        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: self.barView.bottomAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        guard let webUrl = webViewUrl else {return}
        webView.load(URLRequest(url: URL(string: webUrl)!))
    }
}

//MARK: - initializeStoryboard
extension AboutUsDetailsController {
    static func initializeStoryboard() -> AboutUsDetailsController {
        return UIStoryboard(name: "AboutUsDetails", bundle: nil).instantiateViewController(withIdentifier: "AboutUsDetailsController") as! AboutUsDetailsController
    }
}

//MARK: - setupNavigation
extension AboutUsDetailsController {
    private func setupPageGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(rightSwiped))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    @objc func rightSwiped() {
        self.navigationController?.popViewController(animated: true)
    }
}
