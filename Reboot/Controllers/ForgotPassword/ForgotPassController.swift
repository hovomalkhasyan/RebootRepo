//
//  ForgotPassController.swift
//  Reboot
//
//  Created by Hovo on 11/10/20.
//

import UIKit

class ForgotPassController: BaseViewController {

    @IBOutlet weak var emailTf: TextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setupBackBtnColor()
        setupEmailTf()
        tapGesture()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
            emailTf.layer.borderColor = UIColor(named: "borderColor")?.cgColor
            
           }
        }

    }
    
    private func tapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
   private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func setupEmailTf() {
        emailTf.layer.cornerRadius = 10
        emailTf.layer.borderWidth = 1
        emailTf.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        
    }
    
    private func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        guard let email = emailTf.text else {return}
        if isValidEmail(email) == false {
            showAlert(title: "Електронная почта не подтверждена", message: "")
        } else {
            UserDefaults.standard.setValue(email, forKey: "email")
            let vc = UIStoryboard(name: "Code", bundle: nil).instantiateViewController(withIdentifier: "CodeController") as! CodeController
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func toSignIn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        navigationController?.pushViewController(vc, animated: true)
   
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
