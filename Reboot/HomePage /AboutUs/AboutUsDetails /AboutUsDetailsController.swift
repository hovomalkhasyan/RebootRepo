//
//  AboutUsDetailsController.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 08.02.21.
//

import UIKit

class AboutUsDetailsController: BaseViewController {
    //MARK:- IBOutlets
    @IBOutlet weak private var aboutUsWebView: UIWebView!
    @IBOutlet weak private var backButton: UIButton!
    
    //MARK: - propertyes
    var webViewUrl: String?
    
    //MARK: - LifeSycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setupGesture()
        super.setbarView()
        super.workoutsCount()
        setUrlInWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.hideNavBar()
        setupPageGesture()
    }
    
    //MARK: - backBtnAction
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - setupUrlWebView
private extension AboutUsDetailsController {
        func setUrlInWebView() {
        guard let webUrl = webViewUrl else {return}
        let url = URL(string: webUrl)
        let urlRequest = URLRequest(url: url!)
        aboutUsWebView.loadRequest(urlRequest)
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
