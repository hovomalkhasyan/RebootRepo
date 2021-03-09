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
//    var loadingView: UIView!
//    var loading: UIActivityIndicatorView!
    
    //MARK: - hideNavBar
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
        rootBtn.addTarget(self, action: #selector(rottBtnAction), for: .touchUpInside)
    }
    //MARk: - rootBtnAction
    @objc func rottBtnAction() {
        navigationController?.pushViewController(ViewController.initializeStoryboard(), animated: true)
    }
    
    //MARK: - workoutCountRequest
    func workoutsCount() {
//        showView()
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
//                self.hideLoadingView()
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
        
    }
    
    func setupInfoBtn() {
        let infoPop = UITapGestureRecognizer(target: self, action: #selector(infoBtnTap))
        infoPop.numberOfTapsRequired = 1
        infoBtn.addGestureRecognizer(infoPop)
    }
    
    
    //MARK: - ShowLoadingView
//    func showView() {
//        loadingView = UIView()
//        loading = UIActivityIndicatorView(style: .gray)
//        view.addSubview(loadingView)
//        loadingView.addSubview(loading)
//        
//        loadingView.frame = view.frame
//        loadingView.backgroundColor = .white
//        
//        loading.center = self.loadingView.center
//        loading.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        loading.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        
//        loading.startAnimating()
//    }
//    
//    //MARK: - hideLoadingView
//    func hideLoadingView() {
//        loading.stopAnimating()
//        loadingView.removeFromSuperview()
//    }
    
    //NARK: - GestureAction
    @objc private func tapped() {
        let popVC = UIStoryboard(name: "LogOut", bundle: nil).instantiateViewController(withIdentifier: "LogOutViewController") as! LogOutViewController
        self.navigationController?.pushViewController(popVC, animated: true)
        
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
}
//MARK: - extension
extension BaseViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
