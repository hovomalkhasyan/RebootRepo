//
//  AddressController.swift
//  Reboot
//
//  Created by Hovo on 11/12/20.
//

import UIKit
import YandexMapKit

class AddressController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak private var scroll: UIScrollView!
    @IBOutlet weak private var swMapImage: UIImageView!
    @IBOutlet weak private var mapImage: UIImageView!
    @IBOutlet weak private var wpcallBtn: UIButton!
    @IBOutlet weak private var wpCall: UIButton!
    @IBOutlet weak private var secondMap: YMKMapView!
    @IBOutlet weak private var map: YMKMapView!
    @IBOutlet weak private var btnView2: UIView!
    @IBOutlet weak private var btnView: UIView!
    @IBOutlet weak private var scheduleBtnLast: UIButton!
    @IBOutlet weak private var scheduleBtn: UIButton!
    @IBOutlet weak private var rebootEastStack: UIStackView!
    @IBOutlet weak private var rebootSwStack: UIStackView!
    
    //MARK: - Propertyes
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
    
    //MARK: - MapStyle
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
        setupGest()
        setupInfoBtn()
        setbarView()
        setupDarkMode()
        setupBtn()
        setupYKMap()
        setupWpCallBtn()
        addMapObjects()
        setupEastGest()
        workoutsCount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
                scheduleBtn.layer.borderColor = UIColor(named: "borderColor")?.cgColor
                scheduleBtnLast.layer.borderColor = UIColor(named: "borderColor")?.cgColor
            }
        }
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
    
    //MARK: - CallAction
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
    
    //MARK: - wpCallAction
    @IBAction func wpCall(_ sender: UIButton) {
        guard let number = URL(string: "https://api.whatsapp.com/send?phone=\(Constants.REBOOT_PHONE_NUMBER)") else { return }
        UIApplication.shared.open(number)
        
    }
    
    @IBAction func scheduleBtn(_ sender: UIButton) {
        let vc = AboutUsDetailsController.initializeStoryboard()
        switch sender.tag {
        case 0:
            vc.webViewUrl = ConstantStrings.REBOOT_ADDRESS_EAST
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            vc.webViewUrl = ConstantStrings.REBOOT_ADDRESS_EAST
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

private extension AddressController {
    func setupEastGest() {
        let eastGest = UITapGestureRecognizer(target: self, action: #selector(hideSecondMap))
        let swGeast = UITapGestureRecognizer(target: self, action: #selector(hideMap))
        rebootEastStack.addGestureRecognizer(eastGest)
        rebootSwStack.addGestureRecognizer(swGeast)
    }
   
    @objc func hideMap() {
        if hide {
            UIView.animate(withDuration: 0.3) {
                self.secondMap.isHidden = false
            }completion: { (_) in
                self.secondMap.alpha = 1
                self.scroll.isScrollEnabled = false
            }
            self.scroll.scrollToBottom(animated: true)
            swMapImage.image = UIImage(named: "Arrow")
        } else {
            UIView.animate(withDuration: 0.3) {
                self.secondMap.alpha = 0
                self.secondMap.isHidden = true
            }
            self.scroll.isScrollEnabled = true
            swMapImage.image = UIImage(named: "Arrow 02")
        }
        hide = !hide
    }
    
    @objc func hideSecondMap() {
        if isSecondHide {
            UIView.animate(withDuration: 0.3) {
                self.map.isHidden = false
            }completion: { (_) in
                self.map.alpha = 1
                self.scroll.scrollRectToVisible(self.map.frame , animated: true)
                self.scroll.isScrollEnabled = false
            }
            mapImage.image = UIImage(named: "Arrow")
        }else {
            UIView.animate(withDuration: 0.3) {
                self.map.alpha = 0
                self.map.isHidden = true
            }
            self.scroll.isScrollEnabled = true
            mapImage.image = UIImage(named: "Arrow 02")
        }
        isSecondHide = !isSecondHide
    }
}

//MARK: - SetupBtn
private extension AddressController {
    func setupBtn() {
        scheduleBtnLast.layer.borderWidth = 1
        scheduleBtn.layer.borderWidth = 1
        scheduleBtn.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        scheduleBtnLast.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        scheduleBtn.layer.cornerRadius = 2
        scheduleBtnLast.layer.cornerRadius = 2
    }
    
    func setupWpCallBtn() {
        wpCall.setImageColor(color: UIColor(named: "Cellcolors")!, for: .normal)
        wpcallBtn.setImageColor(color: UIColor(named: "Cellcolors")!, for: .normal)
    }
}

//MARK: - Extension
extension AddressController {
    private func setupYKMap() {
        DispatchQueue.main.async {
            self.map.mapWindow.map.move(
                with: YMKCameraPosition.init(target: YMKPoint(latitude: 55.731846, longitude: 37.644379), zoom: self.zoom, azimuth: 0, tilt: 0),
                animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
                cameraCallback: nil)
            self.map.addSubview(self.btnView)
            self.map.mapWindow.map.setMapStyleWithStyle(self.style)
            self.map.isHidden = true
            self.map.alpha = 0
            
            self.secondMap.mapWindow.map.move(with: YMKCameraPosition.init(target: YMKPoint(latitude: 55.736160, longitude: 37.585415), zoom: self.zoom, azimuth: 0, tilt: 0),
                                         animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
                                         cameraCallback: nil)
            self.secondMap.mapWindow.map.setMapStyleWithStyle(self.style)
            self.secondMap.addSubview(self.btnView2)
            self.secondMap.isHidden = true
            self.map.alpha = 0
        }
    }
    
    private func addMapObjects() {
        if let image = UIImage(named: "MAp") {
            let imageView = UIImageView(image: image)
            imageView.bounds.size = CGSize(width: 50, height: 50)
            imageView.backgroundColor = .clear
            YKmap.mapObjects.addPlacemark(with: YMKPoint(latitude: 55.731442, longitude: 37.644889), view: .init(uiView: imageView))
            YKmap.mapObjects.addPlacemark(with: YMKPoint(latitude: 55.736054, longitude: 37.585356), view: .init(uiView: imageView))
            secondYKMap.mapObjects.addPlacemark(with: YMKPoint(latitude: 55.731442, longitude: 37.644889), view: .init(uiView: imageView))
            secondYKMap.mapObjects.addPlacemark(with: YMKPoint(latitude: 55.736054, longitude: 37.585356), view: .init(uiView: imageView))
        }
    }
    
    override func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
        
    }
}

