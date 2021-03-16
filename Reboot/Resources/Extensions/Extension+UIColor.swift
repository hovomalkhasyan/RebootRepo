//
//  Extension+UIColor.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 16.03.21.
//

import Foundation
import UIKit

extension UIColor {

    // MARK: HEX
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int & 0xFF, int >> 24 & 0xFF, int >> 16 & 0xFF, int >> 8 & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(displayP3Red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    // MARK: Default background
    class var appOrangeColor: UIColor {
        return UIColor(hex: "#FF421E")
    }
    class var blackColor: UIColor {
        return UIColor(hex: "#000000")
    }
}
