//
//  CustonNavBar.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 30.12.20.
//

import Foundation
import UIKit

class NavBarViewController: BaseViewController {
    
    var navBar: UIView!
    var backButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavBar()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(rightSwiped))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func rightSwiped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func zeroShadowOpacityNavBar() {
        navBar.layer.shadowOpacity = .zero
        
    }

    func prepareNavBar() {

        navBar = UIView()
        backButton = UIButton()
        self.view.addSubview(navBar)
        navBar.addSubview(backButton)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false

        navBar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        navBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true

        navBar.backgroundColor = UIColor.clear
        navBar.tag = 999


        backButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 10).isActive = true
        backButton.leftAnchor.constraint(equalTo: self.navBar.leftAnchor, constant: 8).isActive = true
        backButton.bottomAnchor.constraint(equalTo: self.navBar.bottomAnchor, constant: -10).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true

        backButton.setImage(UIImage(named: "back-arrow-1"), for: .normal)
        backButton.setImageColor(color: UIColor(named: "borderColor")!, for: .normal)
        backButton.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        backButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        navBar.addSubview(backButton)
     
    }
    
    @objc func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
        
    }

}
