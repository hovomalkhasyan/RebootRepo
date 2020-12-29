//
//  AddressController.swift
//  Reboot
//
//  Created by Hovo on 11/12/20.
//

import UIKit
import YandexMapKit
import SafariServices

class AddressController: BaseViewController {
     
    //MARK: - IBOutlets
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var swMapImage: UIImageView!
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var wpcallBtn: UIButton!
    @IBOutlet weak var wpCall: UIButton!
    @IBOutlet weak var secondMap: YMKMapView!
    @IBOutlet weak var map: YMKMapView!
    @IBOutlet weak var btnView2: UIView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var scheduleBtnLast: UIButton!
    @IBOutlet weak var scheduleBtn: UIButton!
    
    var hide = true
    var isSecondHide = true
    
    var zoom: Float = 15
    var zooms: Float = 15
    
    var YKmap: YMKMap {
        return map.mapWindow.map
        
    }
    
    var secondYKMap: YMKMap {
        return secondMap.mapWindow.map
    }
    
    let style = """
    [{
        "featureType" : "all",
        "stylers" : {
        "saturation" : "-1"
      }
    }
  ]
"""
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setupGesture()
        super.setbarView()
        super.setupDarkMode()
        super.workoutsCount()
        setupBtn()
        setupYKMap()
        setupWpCallBtn()
        addMapObjects()
        
    }
    
    //MARK: - IBActions
    @IBAction func zoomBtn(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            zoom += 1
            YKmap.move(with: YMKCameraPosition(target: YKmap.cameraPosition.target, zoom: self.zoom, azimuth: 0, tilt: 0))
        case 1:
            zoom -= 1
            YKmap.move(with: YMKCameraPosition(target: YKmap.cameraPosition.target, zoom: self.zoom, azimuth: 0, tilt: 0))
        case 2:
            zooms += 1
            secondYKMap.move(with: YMKCameraPosition(target: secondYKMap.cameraPosition.target, zoom: self.zooms, azimuth: 0, tilt: 0))
        case 3:
            zooms -= 1
            secondYKMap.move(with: YMKCameraPosition(target: secondYKMap.cameraPosition.target, zoom: self.zooms, azimuth: 0, tilt: 0))
        default:
            break
            
        }
    }
    
    @IBAction func callAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            guard let number = URL(string: "tel://" + Constants.REBOOT_PHONE_NUMBER) else { return }
            UIApplication.shared.open(number)
        case 1:
            guard let number = URL(string: "tel://" + Constants.REBOOT_SECOND_PHONE_NUMBER) else { return }
            UIApplication.shared.open(number)
        default:
            break
        }
        
    }
    
    @IBAction func wpCall(_ sender: UIButton) {
        guard let number = URL(string: "https://api.whatsapp.com/send?phone=\(Constants.REBOOT_PHONE_NUMBER)") else { return }
        UIApplication.shared.open(number)
        
    }
    
    @IBAction func scheduleBtn(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let url = URL(string: "https://reboot.ru/registration?studio=reboot_east&day")
            let safariController = SFSafariViewController(url: url!)
            present(safariController, animated: true, completion: nil)
        case 1:
            let url = URL(string: "https://reboot.ru/registration?studio=reboot-sw&day")
            let safariController = SFSafariViewController(url: url!)
            present(safariController, animated: true, completion: nil)
        default:
            break
        }
        
    }
    
    @IBAction func hideMao(_ sender: UIButton) {
        if sender.tag == 1 {
            if hide {
                UIView.animate(withDuration: 0.3) {
                    self.secondMap.isHidden = false
                }completion: { (_) in
                    self.secondMap.alpha = 1
                }
                self.scroll.scrollToBottom(animated: true)
                swMapImage.image = UIImage(named: "Arrow")
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.secondMap.alpha = 0
                    self.secondMap.isHidden = true
                }
                swMapImage.image = UIImage(named: "Arrow 02")
            }
            hide = !hide
        } else {
            if isSecondHide {
                UIView.animate(withDuration: 0.3) {
                    self.map.isHidden = false
                }completion: { (_) in
                    self.map.alpha = 1
                }
                mapImage.image = UIImage(named: "Arrow")
            }else {
                UIView.animate(withDuration: 0.3) {
                    self.map.alpha = 0
                    self.map.isHidden = true
                }
                mapImage.image = UIImage(named: "Arrow 02")
            }
            isSecondHide = !isSecondHide
        }
    }
    
}

//MARK: - Extension
extension AddressController {
    private func setupYKMap() {
        map.mapWindow.map.move(
            with: YMKCameraPosition.init(target: YMKPoint(latitude: 55.731846, longitude: 37.644379), zoom: zoom, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
            cameraCallback: nil)
        map.addSubview(btnView)
        map.mapWindow.map.setMapStyleWithStyle(style)
        map.isHidden = true
        map.alpha = 0
        secondMap.mapWindow.map.move(with: YMKCameraPosition.init(target: YMKPoint(latitude: 55.736160, longitude: 37.585415), zoom: zoom, azimuth: 0, tilt: 0),
                                     animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
                                     cameraCallback: nil)
        secondMap.mapWindow.map.setMapStyleWithStyle(style)
        secondMap.addSubview(btnView2)
        secondMap.isHidden = true
        map.alpha = 0
    }
    
    private func addMapObjects() {
        if let image = UIImage(named: "MAp") {
            let imageView = UIImageView(image: image)
            imageView.bounds.size = CGSize(width: 50, height: 50)
            imageView.backgroundColor = .clear
            
            YKmap.mapObjects.addPlacemark(with: YMKPoint(latitude: 55.731846, longitude: 37.644379), view: .init(uiView: imageView))
            secondYKMap.mapObjects.addPlacemark(with: YMKPoint(latitude: 55.736160, longitude: 37.585415), view: .init(uiView: imageView))
        }
        
    }
    
    override func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
                scheduleBtn.layer.borderColor = UIColor(named: "borderColor")?.cgColor
                scheduleBtnLast.layer.borderColor = UIColor(named: "borderColor")?.cgColor
            }
        }
        
    }
    
    private func setupBtn() {
        scheduleBtnLast.layer.borderWidth = 1
        scheduleBtn.layer.borderWidth = 1
        scheduleBtn.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        scheduleBtnLast.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        scheduleBtn.layer.cornerRadius = 2
        scheduleBtnLast.layer.cornerRadius = 2
        
    }
    
    private func setupWpCallBtn() {
        wpCall.setImageColor(color: UIColor(named: "Cellcolors")!, for: .normal)
        wpcallBtn.setImageColor(color: UIColor(named: "Cellcolors")!, for: .normal)
    }
    
}

