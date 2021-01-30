//
//  Extension.swift
//  Reboot
//
//  Created by Hovo on 11/23/20.
//

import Foundation
import UIKit
import Alamofire
import Kingfisher

extension UITextField {
    func disableAutoFill() {
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .init(rawValue: "")
        }
    }
}

extension UIButton {
    public func setImageColor(color: UIColor, for state: UIControl.State) {
        let image = self.image(for: state)
        self.setImage(image?.withRenderingMode(.alwaysTemplate), for: state)
        self.tintColor = color
    }
}

extension String {
    func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = outGoingFormat
        
        return dateFormatter.string(from: dt ?? Date())
    }
}

extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
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


extension Encodable {
    func asDictionary() -> Parameters? {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Parameters else {
                return nil
            }
            return dictionary
        }catch {
            return nil
        }
    }
    
    func asJSON() -> String? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            return jsonString
        } catch {
            return nil
        }
    }
}

extension UIViewController {
        func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

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
//                button.imageView?.alpha = 0
//                button.titleLabel?.alpha = 0
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
//                button.imageView?.alpha = 1
//                button.titleLabel?.alpha = 1
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

public extension UIResponder {
    class var name: String {
        return String(describing: self)
    }
}

extension UITableView {
    func registerCellFromXib(cell: UITableViewCell.Type) {
        self.register(UINib(nibName: cell.name, bundle: nil), forCellReuseIdentifier: cell.name)
    }
}

