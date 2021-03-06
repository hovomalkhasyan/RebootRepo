//
//  ForgotPassController.swift
//  Reboot
//
//  Created by Hovo on 11/10/20.
//

import UIKit

class ForgotPassController: NavBarViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak private var emailTf: TextField!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.zeroShadowOpacityNavBar()
        super.rootBtnSetup()
        setupEmailTf()
        tapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.hideNavBar()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
                emailTf.layer.borderColor = UIColor(named: "borderColor")?.cgColor
            }
        }
    }
    
    //MARK: - IBAtions
    @IBAction func nextAction(_ sender: UIButton) {
        guard let email = emailTf.text else {return}
        if isValidEmail(email) == false {
            showAlert(title: "Електронная почта не подтверждена", message: "")
        } else {
            UserDefaults.standard.setValue(email, forKey: "email")
            navigationController?.pushViewController(CodeController.initializeStoryboard(), animated: true)
        }
    }
}

//MARK: - Extension
extension ForgotPassController {
    private func tapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func setupEmailTf() {
        emailTf.layer.cornerRadius = 10
        emailTf.layer.borderWidth = 1
        emailTf.layer.borderColor = UIColor(named: "borderColor")?.cgColor
    }
}

//MARK: - InitializeStoryboard
extension ForgotPassController {
    static func initializeStoryboard() -> ForgotPassController {
        return UIStoryboard(name: "ForgotPassword", bundle: nil).instantiateViewController(withIdentifier: "ForgotPassController") as! ForgotPassController
    }
}
