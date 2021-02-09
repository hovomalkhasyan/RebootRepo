//
//  RegisterController.swift
//  Reboot
//
//  Created by Hovo on 11/10/20.
//

import UIKit
import Alamofire

class RegisterController: NavBarViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak private var registerStack: UIStackView!
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var password: UITextField!
    @IBOutlet weak private var work: UITextField!
    @IBOutlet weak private var birthDay: UITextField!
    @IBOutlet weak private var email: UITextField!
    @IBOutlet weak private var phoneNumber: UITextField!
    @IBOutlet weak private var fullName: UITextField!
    
    //MARK: - propertyes
    private let datePicker = UIDatePicker()
    private let toolbar = UIToolbar()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.rootBtnSetup()
        super.zeroShadowOpacityNavBar()
        setupTeftFields()
        tapGesture()
        setupBirthDayTf()
        setupStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.hideNavBar()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
                setupStackView()
            }
        }
    }
    
    //MARK: - IBActions
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
}

//MARK: - PostRequest
extension RegisterController {
    private func registerRequest(_ completion: @escaping () -> Void) {
        
        let model = RegisterParams(birth_date: birthDay.text, email: email.text, first_name: fullName.text, occupation: work.text, password: password.text, phone: phoneNumber.text)
        NetWorkService.request(url: Constants.AUTH_REGISTER_ENDPOINT, method: .post, param: model, encoding: JSONEncoding.default) { (resp: RequestResult<LoginResponse?>) in
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
}

//MARK: - Extension
extension RegisterController {
    func setupStackView() {
        let color = UIColor(named: "borderColor")
        for sub in registerStack.subviews {
            sub.layer.cornerRadius = 10
            sub.layer.borderWidth = 1
            guard let borderColor = color else {return}
            sub.layer.borderColor = borderColor.cgColor
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - Setup
private extension RegisterController {
    
    func setupBirthDayTf() {
        let tulbarBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flaxSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil )
        toolbar.setItems([flaxSpace,tulbarBtn], animated: true)
        birthDay.inputAccessoryView = toolbar
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        birthDay.inputView = datePicker
        datePicker.datePickerMode = .date
        toolbar.sizeToFit()
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
}

//MARK: TextFieldDelegate
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

//MARK: - InitializeStoryboard
extension RegisterController {
    static func initializeStoryboard() -> RegisterController {
        return UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "RegisterController") as! RegisterController
    }
}

private extension RegisterController {
    func showPopUp(title: String) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
