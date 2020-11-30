//
//  SavePasswordController.swift
//  Reboot
//
//  Created by Hovo on 11/10/20.
//

import UIKit

class SavePasswordController: UIViewController {
    
    @IBOutlet weak var passwordTF: TextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextTF()
        tapGesture()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
            passwordTF.layer.borderColor = UIColor(named: "borderColor")?.cgColor
            
           }
        }
        
    }
    
    
    private func setupNavigation() {
        navigationController?.isNavigationBarHidden = true
        
    }
    
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
    
    @IBAction func savePassword(_ sender: UIButton) {
        
    }
    
    @IBAction func yoSignIn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
