//
//  Extension+NSMutableAttributedString.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 30.01.21.
//

import Foundation
import UIKit
extension NSMutableAttributedString {

    @discardableResult func withBold(_ text: String, size: CGFloat = 17) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.GilroyBold(size: size),
            NSAttributedString.Key.foregroundColor: UIColor.black]
        let normal = NSMutableAttributedString(string:text, attributes: attrs)
        append(normal)
        
        return self
    }
    
    @discardableResult func withUltraLightItalic(_ text: String, size: CGFloat = 17) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.GiloryUltraLightItalic(size: size),
            NSAttributedString.Key.foregroundColor: UIColor.black]
        let normal = NSMutableAttributedString(string:text, attributes: attrs)
        append(normal)
        
        return self
    }
    
    @discardableResult func withGiloryMadium(_ text: String, size: CGFloat = 17) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.GiloryMadium(size: size),
            NSAttributedString.Key.foregroundColor: UIColor.black]
        let normal = NSMutableAttributedString(string:text, attributes: attrs)
        append(normal)
        
        return self
    }
    
    @discardableResult func withGilroyRegular(_ text: String, size: CGFloat = 17) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.GilroyRegular(size: size),
            NSAttributedString.Key.foregroundColor: UIColor.black]
        let normal = NSMutableAttributedString(string:text, attributes: attrs)
        append(normal)
        
        return self
    }
    
    @discardableResult func withColorGiloryMadium(_ text: String, size: CGFloat = 14) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.GiloryMadium(size: size),
            NSAttributedString.Key.foregroundColor: UIColor.appOrangeColor]
        let normal = NSMutableAttributedString(string:text, attributes: attrs)
        append(normal)
        
        return self
    }
}
