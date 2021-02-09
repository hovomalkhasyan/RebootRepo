//
//  CodeController.swift
//  Reboot
//
//  Created by Hovo on 11/10/20.
//

import UIKit

class CodeController: NavBarViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak private var codeTF: TextField!
    @IBOutlet weak private var messageLbl: UILabel!
    
    //MARK:- LifeSycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.rootBtnSetup()
        super.zeroShadowOpacityNavBar()
        setupTextTF()
        tapGesture()
        setupMessageLbl()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
                codeTF.layer.borderColor = UIColor(named: "borderColor")?.cgColor
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.hideNavBar()
    }
    
    //MARK:- IBActions
    @IBAction func confirmeAction(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "email")
        navigationController?.pushViewController(SavePasswordController.initializeStoryboard(), animated: true)
    }
}

//MARK:- Extension
extension CodeController {
    private func setupMessageLbl() {
        guard let email = UserDefaults.standard.string(forKey: "email") else {return}
        messageLbl.text = "Введите код, который мы отправили по адресу \(email)"
    }
    
    private func tapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupTextTF() {
        codeTF.layer.cornerRadius = 10
        codeTF.layer.borderWidth = 1
        codeTF.layer.borderColor = UIColor(named: "borderColor")?.cgColor
    }
}

//MARK: - InitializeStoryboard
extension CodeController {
    static func initializeStoryboard() -> CodeController {
        return UIStoryboard(name: "Code", bundle: nil).instantiateViewController(withIdentifier: "CodeController") as! CodeController
    }
}
