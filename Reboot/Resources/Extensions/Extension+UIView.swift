//
//  Extension+UIView.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 30.01.21.
//

import Foundation
import UIKit

extension UIView {

    // MARK: - Loading
    func startLoading(beginIgnoringInteraction: Bool = true) {
        self.activityIndicator.style = backgroundColor == .white ? .gray : .white
        if beginIgnoringInteraction {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        UIView.animate(withDuration: 0.1) {
            if let button = self as? UIButton {
                button.imageView?.layer.transform = CATransform3DMakeScale(0, 0, 0)
                button.titleLabel?.layer.transform = CATransform3DMakeScale(0, 0, 0)
            }
            self.activityIndicator.alpha = 1
            self.activityIndicator.startAnimating()
        }
    }

    func endLoading() {
        UIApplication.shared.endIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.1) {
            if let button = self as? UIButton {
                button.imageView?.layer.transform = CATransform3DIdentity
                button.titleLabel?.layer.transform = CATransform3DIdentity
            }
            self.activityIndicator.alpha = 0
            self.activityIndicator.stopAnimating()
        }
    }

    private var activityIndicator: UIActivityIndicatorView {
        if let activityIndicator = (subviews.first { $0.accessibilityIdentifier == "custom_loading" }) as? UIActivityIndicatorView {
            return activityIndicator
        }

        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)

        activityIndicator.alpha = 0
        activityIndicator.stopAnimating()
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.accessibilityIdentifier = "custom_loading"

        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        return activityIndicator
    }
}
