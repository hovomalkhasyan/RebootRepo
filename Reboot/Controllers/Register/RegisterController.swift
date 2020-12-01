//
//  RegisterController.swift
//  Reboot
//
//  Created by Hovo on 11/10/20.
//

import UIKit
import Alamofire

class RegisterController: BaseViewController {
    
    private let registerEndPoint = "auth/register/"
    
    @IBOutlet weak var registerStack: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var work: UITextField!
    @IBOutlet weak var birthDay: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var fullName: UITextField!
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTeftFields()
        tapGesture()
        setupBirthDayTf()
        setupStackView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
                setupStackView()
           }
       }
        
    }
    
    
    
    func setupStackView() {
            let color = UIColor(named: "borderColor")
        for v in registerStack.subviews {
            v.layer.cornerRadius = 10
            v.layer.borderWidth = 1
            guard let borderColor = color else {return}
            v.layer.borderColor = borderColor.cgColor
        }
        
    }
    
    
    private func setupBirthDayTf() {
        
        birthDay.inputView = datePicker
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let tulbarBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flaxSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil )
        toolbar.setItems([flaxSpace,tulbarBtn], animated: true)
        birthDay.inputAccessoryView = toolbar
        
    }
    
    @objc func doneAction() {
        getDateFromPicker()
        self.view.endEditing(true)
        
    }
    
    private func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-dd-MM"
        birthDay.text = formatter.string(from: datePicker.date)
        
    }
    
    private func setupNavigationController() {
        navigationController?.isNavigationBarHidden = true
        
    }
    
    private func tapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    private func setupTeftFields() {
        password.delegate = self
        work.delegate = self
        birthDay.delegate = self
        email.delegate = self
        phoneNumber.delegate = self
        fullName.delegate = self
        password.isSecureTextEntry = true
        password.textContentType = UITextContentType(rawValue: "")
        
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
        
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        present(alert, animated: true, completion: nil)
        
    }
    
    private func registerRequest(_ completion: @escaping () -> Void) {
        
        let model = RegisterParams(birth_date: birthDay.text, email: email.text, first_name: fullName.text, occupation: work.text, password: password.text, phone: phoneNumber.text)
        NetWorkService.request(url: registerEndPoint, method: .post, param: model, encoding: JSONEncoding.default) { (resp: RequestResult<LoginResponse?>) in
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
    
    
    @IBAction func register(_ sender: UIButton) {
        self.view.endEditing(true)
        if CheckInternet.Connection() {
            if email.text == "" || password.text == "" || phoneNumber.text == "" {
                showAlert(title: "Заполните обязательные поля", message: "")
            } else {
                guard let emails = email.text else {return}
                if isValidEmail(emails) == false {
                    showAlert(title: "Електронная почта не подтверждена", message: "")
                } else  {
                    guard let password = password.text?.count else {return}
                    if password < 8 {
                        showAlert(title: "Пороль менее 8", message: "")
                    } else {
                        sender.isUserInteractionEnabled = false
                        registerRequest {
                            sender.isUserInteractionEnabled = true
                        }
                    }
                }
            }
        }
    
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

extension RegisterController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        
        case fullName:
            phoneNumber.becomeFirstResponder()
            
        case phoneNumber:
            email.becomeFirstResponder()
            
        case email:
            birthDay.becomeFirstResponder()
            
        case birthDay:
            work.becomeFirstResponder()
            
        case work:
            password.becomeFirstResponder()
            
        case password:
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


struct RegisterParams: Codable {
    let birth_date, email, first_name, occupation, password, phone : String?
}
