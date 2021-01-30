//
//  Extension+UIViewController.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 30.01.21.
//

import Foundation
import UIKit

extension UIViewController {
        func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
