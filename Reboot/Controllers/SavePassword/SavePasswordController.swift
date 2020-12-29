//
//  SavePasswordController.swift
//  Reboot
//
//  Created by Hovo on 11/10/20.
//

import UIKit

class SavePasswordController: BaseViewController {
    //MARK: - InitializeStoryboard
    static func initializeStoryboard() -> SavePasswordController {
        return UIStoryboard(name: "SavePassword", bundle: nil).instantiateViewController(withIdentifier: "SavePasswordController") as! SavePasswordController
        
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var passwordTF: TextField!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setupBackBtnColor()
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
    
    @IBAction func yoSignIn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Code", bundle: nil).instantiateViewController(withIdentifier: "CodeController")
        navigationController?.pushViewController(vc, animated: true)
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
