//
//  Extension+UIResponder.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 30.01.21.
//

import Foundation
import UIKit

public extension UIResponder {
    class var name: String {
        return String(describing: self)
    }
}
