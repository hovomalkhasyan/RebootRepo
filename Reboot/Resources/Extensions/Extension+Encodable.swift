//
//  Extension+Encodable.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 30.01.21.
//

import Foundation
import Alamofire

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
