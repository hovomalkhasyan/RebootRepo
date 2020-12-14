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
        YMKMapKit.setApiKey(Constants.YANDEX_API_KEY)
        
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


