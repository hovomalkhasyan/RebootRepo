//
//  SplashController.swift
//  Reboot
//
//  Created by Hovo on 11/27/20.
//

import UIKit
import AVFoundation
import AVKit

class SplashController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Reboot", ofType: "mov")!))
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupSplash()
    }
    
    private func setupSplash() {
        indicator.color = .white
        indicator.startAnimating()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.showRebootVideo), userInfo: nil, repeats: false)
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)

    }
    
    @objc private func showRebootVideo() {
        indicator.stopAnimating()
        setupSplashVideo()
        
    }
    
    
    @objc func playerDidFinishPlaying(note: NSNotification){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Navigation")
        let HomeVc = UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "TabBar")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if #available(iOS 13, *) {
            if UserDefaults.standard.value(forKey: "token") != nil {
                UIApplication.shared.windows.first?.rootViewController = HomeVc
            }else {
                UIApplication.shared.windows.first?.rootViewController = vc
            }
        } else {
            if UserDefaults.standard.value(forKey: "token") != nil {
                appDelegate.window?.rootViewController = HomeVc
            } else {
                appDelegate.window?.rootViewController = vc
            }
        }
        
    }
    
    private func setupSplashVideo() {
        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(layer)
        player.play()
        
    }
    
}
