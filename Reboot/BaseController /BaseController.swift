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
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var rootBtn: UIButton!
    
    //MARK: - property
    var sum = 0
    
    //MARK: - setupNavBar
    func hideNavBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - setupDarkMode
    func setupDarkMode() {
        logOutBtn.setImage(UIImage(named:  "user"), for: .normal)
        logo.image = UIImage(named: "Group 6544")
        logOutBtn.setImageColor(color: UIColor(named: "borderColor")!, for: .normal)
    }
    
    //MARK: - buttonAction
    func rootBtnSetup() {
        rootBtn.addTarget(self, action: #selector(rottBtnAction), for: .touchDragInside)
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
                guard let data = data else {return}
                if data?.packages?.count == 0 {
                    self.infoBtn.setTitle("0", for: .normal)
                }else {
                    guard let package = data?.packages else {return}
                    package.forEach { p in
                        self.sum += p.workoutsCount
                    }
                    self.infoBtn.setTitle(String(self.sum), for: .normal)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - setupGesture
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTapsRequired = 1
        logOutBtn.addGestureRecognizer(tapGesture)
        
        let infoPop = UITapGestureRecognizer(target: self, action: #selector(infoBtnTap))
        tapGesture.numberOfTapsRequired = 1
        infoBtn.addGestureRecognizer(infoPop)
    }
    
    //NARK: - GestureAction
    @objc private func tapped() {
        
        let popVC = UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "PopUpController") as! PopUpController
        popVC.modalPresentationStyle = .popover
        
        let popoverVC = popVC.popoverPresentationController
        popoverVC?.delegate = self
        popoverVC?.sourceView = self.logOutBtn
        popoverVC?.sourceRect = CGRect(x: self.logOutBtn.bounds.width/2 , y: self.logOutBtn.bounds.maxY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 189, height: 223)
        
        self.present(popVC, animated: true, completion: nil)
    }
    
    //MARK: - infoBtnAction
    @objc private func infoBtnTap() {
        
        let popVC = UIStoryboard(name: "PnPopup", bundle: nil).instantiateViewController(withIdentifier: "PopupController") as! PopupController
        popVC.modalPresentationStyle = .custom
        self.presentPanModal(popVC)
        //        let popVC = UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "InfoController") as! InfoController
        //        popVC.modalPresentationStyle = .overFullScreen
        //        let popoverVC = popVC.popoverPresentationController
        //        popoverVC?.delegate = self
        //        popoverVC?.sourceView = self.infoBtn
        //        popoverVC?.sourceRect = CGRect(x: self.infoBtn.bounds.height/2, y: self.infoBtn.bounds.maxY, width: 0, height: 0)
        //        popVC.preferredContentSize = CGSize(width: 146, height: 123)
        //
        //        self.present(popVC, animated: true, completion: nil)
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
}
//MARK: - extension
extension BaseViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
