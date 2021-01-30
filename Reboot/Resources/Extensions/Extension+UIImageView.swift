//
//  Extension+UIImageView.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 30.01.21.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension UIImageView {
    func setImage(urlString: String?, placeholder: UIImage? = nil, completed: (() -> Void)? = nil) {
        guard let string = urlString else {
            image = placeholder
            return
        }
        
        kf.setImage(with: URL(string: string), placeholder: placeholder, completionHandler: { _ in
            completed?()
        })
    }
}
