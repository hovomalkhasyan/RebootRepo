//
//  ViewController.swift
//  Reboot
//
//  Created by Hovo on 11/10/20.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
    
    private var iconClick = true
    
    @IBOutlet weak var emailTf: TextField!
    @IBOutlet weak var passwordTF: TextField!
    @IBOutlet weak var loginBtn: UIButton!
 
    @IBOutlet weak var passwordShowBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setupTf()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
      
    }
    
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
                passwordTF.layer.borderColor = UIColor(named: "borderColor")?.cgColor
                emailTf.layer.borderColor = UIColor(named: "borderColor")?.cgColor
            }
 
    
    private func setupNavigationController() {
        navigationController?.isNavigationBarHidden = true
        
    }
    
    private func setupTextFields() {
        emailTf.delegate = self
        passwordTF.delegate = self
        passwordTF.isSecureTextEntry = true

    }
    
    private func setupTf() {
        emailTf.layer.borderWidth = 1
        emailTf.layer.cornerRadius = 10
        passwordTF.layer.borderWidth = 1
        passwordTF.layer.cornerRadius = 10
        passwordTF.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        emailTf.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let tulbarBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        let flaxSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil )
        toolbar.setItems([flaxSpace,tulbarBtn], animated: true)
        emailTf.inputAccessoryView = toolbar
        passwordTF.inputAccessoryView = toolbar
        
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    @IBAction func showPasswordAction(_ sender: UIButton) {
        if iconClick  {
            passwordTF.isSecureTextEntry = false
            passwordShowBtn.setImage(UIImage(named: "eye"), for: .normal)
            passwordShowBtn.setImageColor(color: UIColor(named: "borderColor")!, for: .normal)
           
        } else {
            passwordTF.isSecureTextEntry = true
            passwordShowBtn.setImage(UIImage(named: "Eye 02"), for: .normal)
            passwordShowBtn.setImageColor(color: UIColor(named: "borderColor")!, for: .normal)
            
        }
        
        iconClick = !iconClick
        
    }
    
    private func loginRequest(_ completion: @escaping () -> Void) {
        
        let model =  LoginParameters(username: emailTf.text, password: passwordTF.text)
        NetWorkService.request(url: Constants.AUTH_LOGIN_ENDPOINT, method: .post, param: model, encoding: JSONEncoding.prettyPrinted) { (resp: RequestResult<LoginResponse?>) in
            completion()
            switch resp {
            case .success(let data):
                guard let data = data else {return}
                UserDefaults.standard.setValue(data?.token, forKey: "token")
                let vc = UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "TabBar")
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                print(error)
            }
        }

    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        if CheckInternet.Connection() {
            self.view.endEditing(true)
            if passwordTF.text == "" ||  emailTf.text == "" {
                showAlert(title: "Заполните все поля", message: "")
            }else {
                guard let emails = emailTf.text else {return}
                if isValidEmail(emails) == false {
                    showAlert(title: "Електронная почта не подтверждена", message: "")
                } else {
                    sender.isUserInteractionEnabled = false
                    loginRequest {
                        sender.isUserInteractionEnabled = true
                    }
                    
                }
            }
        }
        
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let vc = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "RegisterController") as! RegisterController
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = UIStoryboard(name: "ForgotPassword", bundle: nil).instantiateViewController(withIdentifier: "ForgotPassController") as! ForgotPassController
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}



extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {

        case emailTf:
            passwordTF.becomeFirstResponder()

        case passwordTF:
            UIView.animate(withDuration: 1) {
                self.view.endEditing(true)
            }

        default:
            break
        }

        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

}


struct LoginParameters: Codable {
    let username, password: String?
}
