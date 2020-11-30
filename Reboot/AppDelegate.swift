//
//  AppDelegate.swift
//  Reboot
//
//  Created by Hovo on 11/10/20.
//

import UIKit
import YandexMapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    var restrictRotation:UIInterfaceOrientationMask = .portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        YMKMapKit.setApiKey("104532f6-e615-407f-a2b1-1c13e5a64a9d")
        
        self.window = UIWindow()
        let vc = UIStoryboard(name: "Splash", bundle: nil).instantiateViewController(withIdentifier: "SplashController")
        self.window!.rootViewController = vc
        self.window!.makeKeyAndVisible()
        
    return true
}

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
    {
        return self.restrictRotation
    }
    
}


