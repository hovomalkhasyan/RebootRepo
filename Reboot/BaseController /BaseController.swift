//
//  BaseController.swift
//  Reboot
//
//  Created by Hovo on 11/13/20.
//

import Foundation
import UIKit
import Alamofire

class BaseViewController: UIViewController {
    //MARK: - IBoutlets
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var rootBtn: UIButton!
    

    
    func hideNavBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupDarkMode() {
        logOutBtn.setImage(UIImage(named:  "user"), for: .normal)
        logo.image = UIImage(named: "Group 6544")
        logOutBtn.setImageColor(color: UIColor(named: "borderColor")!, for: .normal)
        
    }
    
    func rootBtnSetup() {
        rootBtn.addTarget(self, action: #selector(rottBtnAction), for: .touchDragInside)
    }
    
    @objc func rottBtnAction() {
        navigationController?.pushViewController(ViewController.initializeStoryboard(), animated: true)
    }
    
   func workoutsCount() {
    NetWorkService.request(url: Constants.MY_ACCOUNT_ENDPOINT, method: .get, param: nil, encoding: JSONEncoding.prettyPrinted) { (resp: RequestResult<AccountResponse?>) in
            switch resp {
            case .success(let data):
                guard let data = data else {return}
                if data?.packages?.count == 0 {
                    self.infoBtn.setTitle("0", for: .normal)
                }else {
                    guard let package = data?.packages else {return}
                    self.infoBtn.setTitle(String(package[0].plan.workoutsCount), for: .normal)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    
    }
    
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTapsRequired = 1
        logOutBtn.addGestureRecognizer(tapGesture)
        
        let infoPop = UITapGestureRecognizer(target: self, action: #selector(infoBtnTap))
        tapGesture.numberOfTapsRequired = 1
        infoBtn.addGestureRecognizer(infoPop)
        
    }

    @objc private func tapped() {
        
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopUpController") else {return}
        popVC.modalPresentationStyle = .popover
        
        let popoverVC = popVC.popoverPresentationController
        popoverVC?.delegate = self
        popoverVC?.sourceView = self.logOutBtn
        popoverVC?.sourceRect = CGRect(x: self.logOutBtn.bounds.width/2 , y: self.logOutBtn.bounds.maxY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 189, height: 223)
        
        self.present(popVC, animated: true, completion: nil)
        
    }
    
    
    @objc private func infoBtnTap() {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "InfoController") else {return}
        popVC.modalPresentationStyle = .popover
        let popoverVC = popVC.popoverPresentationController
        popoverVC?.delegate = self
        popoverVC?.sourceView = self.infoBtn
        popoverVC?.sourceRect = CGRect(x: self.infoBtn.bounds.height/2, y: self.infoBtn.bounds.maxY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 146, height: 123)
        
        self.present(popVC, animated: true, completion: nil)
        
    }
    
    func setbarView() {
        barView.layer.shadowColor =  UIColor.black.withAlphaComponent(0.16).cgColor
        barView.layer.shadowOffset = CGSize(width: 0, height: 6)
        barView.layer.shadowOpacity = 1
        
    }
    
}

extension BaseViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
