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
}
