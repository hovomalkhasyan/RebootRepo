//
//  BaseController.swift
//  Reboot
//
//  Created by Hovo on 11/13/20.
//

import Foundation
import UIKit
import Alamofire
import PanModal
class BaseViewController: UIViewController {
    //MARK: - IBoutlets
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var logOutPageImage: UIImageView!
    @IBOutlet weak var rootBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerForKeyboardNotification()
    }
    
    deinit {
        deregisterFromKeyboardNotification()
    }
   
    //MARK: - property
    var sum = 0
    
    //MARK: - hideNavBar
    func hideNavBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - setupDarkMode
    func setupDarkMode() {
        logOutPageImage.setImageColor(color: UIColor(named: "borderColor")!)
        logo.image = UIImage(named: "Group 6544")
    }
    
    //MARK: - buttonAction
    func rootBtnSetup() {
        rootBtn.addTarget(self, action: #selector(rottBtnAction), for: .touchUpInside)
    }
    //MARk: - rootBtnAction
    @objc func rottBtnAction() {
        navigationController?.pushViewController(ViewController.initializeStoryboard(), animated: true)
    }
    
    //MARK: - workoutCountRequest
    func workoutsCount() {
        NetWorkService.request(url: Constants.MY_ACCOUNT_ENDPOINT, method: .get, param: nil, encoding: JSONEncoding.prettyPrinted) { (resp: RequestResult<AccountResponse?>) in
            switch resp {
            case .success(let data):
                guard let responeData = data, let packages = responeData?.packages else {return}
                if !packages.isEmpty {
                    packages.forEach { p in
                        self.sum += p.workoutsCount
                    }
                    self.infoBtn.setTitle(String(self.sum), for: .normal)
                } else {
                    self.infoBtn.setTitle("0", for: .normal)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - setupGesture
    func setupGest() {
        let gest = UITapGestureRecognizer(target: self, action: #selector(tapped))
        logOutPageImage.isMultipleTouchEnabled = true
        logOutPageImage.isUserInteractionEnabled = true
        logOutPageImage.addGestureRecognizer(gest)
    }
    
    func setupInfoBtn() {
        let infoPop = UITapGestureRecognizer(target: self, action: #selector(infoBtnTap))
        infoPop.numberOfTapsRequired = 1
        infoBtn.addGestureRecognizer(infoPop)
    }
    
    //NARK: - GestureAction
    @objc private func tapped() {
        let popVC = UIStoryboard(name: "LogOut", bundle: nil).instantiateViewController(withIdentifier: "LogOutViewController") as! LogOutViewController
        self.navigationController?.pushViewController(popVC, animated: true)
        print("tap")
    }
    
    //MARK: - infoBtnAction
    @objc private func infoBtnTap() {
        let popVC = UIStoryboard(name: "PnPopup", bundle: nil).instantiateViewController(withIdentifier: "PopupController") as! PopupController
        popVC.modalPresentationStyle = .custom
        self.presentPanModal(popVC)
        
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - setupbar
    func setbarView() {
        barView.layer.shadowColor =  UIColor.black.withAlphaComponent(0.16).cgColor
        barView.layer.shadowOffset = CGSize(width: 0, height: 6)
        barView.layer.shadowOpacity = 1
    }
    
    //MARK: - KeyboardNotifications
    func registerForKeyboardNotification() {
        deregisterFromKeyboardNotification()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    func deregisterFromKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc private func keyboardNotification(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo, let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if endFrame.origin.y >= UIScreen.main.bounds.size.height {
            self.view.endEditing(true)
            removeTapGestureForKeyboard()
            let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            keyboardHandler(contentInset)
        } else {
            hideKeyboardWhenTappedAround()
            let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: endFrame.height, right: 0.0)
            keyboardHandler(contentInset)
        }
    }

    @objc func keyboardHandler(_ contentInset: UIEdgeInsets) {
        
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.view?.tag = 12
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func removeTapGestureForKeyboard() {
        if ((self.view.gestureRecognizers?.count) != nil) {
            for gesture in self.view.gestureRecognizers! {
                if let x = gesture as? UISwipeGestureRecognizer {
                    print(x)
                } else {
                    self.view.removeGestureRecognizer(gesture)
                }
            }
        }
    }
}

//MARK: - extension
extension BaseViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
