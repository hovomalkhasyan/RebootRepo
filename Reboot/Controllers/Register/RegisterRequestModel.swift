//
//  RegisterRequestModel.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 29.12.20.
//

import Foundation
struct RegisterParams: Codable {
    let birth_date, email, first_name, occupation, password, phone : String?
    
}
