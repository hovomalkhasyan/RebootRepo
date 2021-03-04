//
//  PricingController.swift
//  Reboot
//
//  Created by Hovo on 11/13/20.
//

import UIKit

class PricingController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak private var webView: UIWebView!
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        setupDarkMode()
        setbarView()
        setUrlInWebView()
        workoutsCount()
    }
}

//MARK: - setupWebView
extension PricingController {
    private func setUrlInWebView() {
        let url = URL(string: "https://reboot.ru/pricing")
        let urlRequest = URLRequest(url: url!)
        webView.loadRequest(urlRequest)
        
    }
}
//MARK: - InitialStoryboard
extension PricingController {
    static func initializeStoryboard() -> PricingController {
        return UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "PricingController") as! PricingController
    }
}
