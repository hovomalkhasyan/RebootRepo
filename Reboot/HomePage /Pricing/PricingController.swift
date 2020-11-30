//
//  PricingController.swift
//  Reboot
//
//  Created by Hovo on 11/13/20.
//

import UIKit

class PricingController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUrlInWebView()

    }
    
    private func setUrlInWebView() {
        let url = URL(string: "https://reboot.ru/pricing")
        let urlRequest = URLRequest(url: url!)
        webView.loadRequest(urlRequest)
        
    }

}
