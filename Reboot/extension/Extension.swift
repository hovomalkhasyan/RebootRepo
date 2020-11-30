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


