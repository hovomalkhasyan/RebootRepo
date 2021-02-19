//
//  Extension+String.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 30.01.21.
//

import Foundation

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
//
//    var formatedPhoneNumber: String {
//        var number = self
//        switch number.prefix(1) {
//        case "+":
//            return number
//        case "00":
//            number.removeFirst(2)
//            return "+" + number
//        case "0":
//            number.removeFirst()
//            return "+374" + number
//        case "374":
//            return "+" + number
//        default:
//            return "+374" + number
//        }
//    }
}
