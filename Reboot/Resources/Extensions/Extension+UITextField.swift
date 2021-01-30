//
//  Extension+UITextField.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 30.01.21.
//

import Foundation
import UIKit

extension UITextField {
    func disableAutoFill() {
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .init(rawValue: "")
        }
    }
}
