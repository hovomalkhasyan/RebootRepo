//
//  TextField.swift
//  Reboot
//
//  Created by Hovo on 11/10/20.
//

import Foundation
import UIKit

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 50)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}


