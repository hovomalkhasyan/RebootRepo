//
//  SavePasswordController.swift
//  Reboot
//
//  Created by Hovo on 11/10/20.
//

import UIKit

class SavePasswordController: NavBarViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak private var passwordTF: TextField!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.zeroShadowOpacityNavBar()
        super.rootBtnSetup()
        setupTextTF()
        tapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.hideNavBar()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
                passwordTF.layer.borderColor = UIColor(named: "borderColor")?.cgColor
                
            }
        }
    }
    
    //MARK: - IBActions
    @IBAction func savePassword(_ sender: UIButton) {
        
    }
}

//MARK: - Extension 
extension SavePasswordController {
    private func tapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupTextTF() {
        passwordTF.layer.borderWidth = 1
        passwordTF.layer.cornerRadius = 10
        passwordTF.layer.borderColor = UIColor(named: "borderColor")?.cgColor
    }
}

//MARK: - InitializeStoryboard
extension SavePasswordController {
    static func initializeStoryboard() -> SavePasswordController {
        return UIStoryboard(name: "SavePassword", bundle: nil).instantiateViewController(withIdentifier: "SavePasswordController") as! SavePasswordController
    }
}
