//
//  PricingController.swift
//  Reboot
//
//  Created by Hovo on 11/13/20.
//

import UIKit

class PricingController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var webView: UIWebView!
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setupGesture()
        super.setupDarkMode()
        super.workoutsCount()
        super.setbarView()
        setUrlInWebView()
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

extension PricingController {
    static func initializeStoryboard() -> PricingController {
        return UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "PricingController") as! PricingController
    }
}
