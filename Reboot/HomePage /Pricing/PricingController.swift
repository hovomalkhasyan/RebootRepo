//
//  PricingController.swift
//  Reboot
//
//  Created by Hovo on 11/13/20.
//

import UIKit
import WebKit

class PricingController: BaseViewController {
    
    //MARK: - IBOutlets
    private var webView: WKWebView!
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        setupInfoBtn()
        setupDarkMode()
        setbarView()
        setUrlInWebView()
        workoutsCount()
        addMapView()
    }
}

//MARK: - setupWebView
private extension PricingController {
    func setUrlInWebView() {
        let url = URL(string: "https://reboot.ru/pricing")
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
    }
    
    func addMapView() {
        webView = WKWebView(frame: self.view.frame)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        
        webView.topAnchor.constraint(equalTo: self.barView.bottomAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
}

//MARK: - InitialStoryboard
extension PricingController {
    static func initializeStoryboard() -> PricingController {
        return UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "PricingController") as! PricingController
    }
}
