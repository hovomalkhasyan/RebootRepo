//
//  Extension+UIButton.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 30.01.21.
//

import Foundation
import UIKit

extension UIButton {
    public func setImageColor(color: UIColor, for state: UIControl.State) {
        let image = self.image(for: state)
        self.setImage(image?.withRenderingMode(.alwaysTemplate), for: state)
        self.tintColor = color
    }
}
