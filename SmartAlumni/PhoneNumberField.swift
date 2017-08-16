//
//  File.swift
//  SmartAlumni
//
//  Created by Jubril on 8/7/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import UIKit
import PhoneNumberKit

enum PhoneNumberValidity {
    case invalid
    case valid(PhoneNumber)
}

extension PhoneNumberTextField {
    
    func validate() -> PhoneNumberValidity {
        
        guard let rawPhoneNumberString = self.text else {
            return .invalid
        }
        
        let phoneNumberKit = PhoneNumberKit()
        do {
            let phoneNumber = try phoneNumberKit.parse(rawPhoneNumberString)
            return .valid(phoneNumber)
        }
        catch {
            print("Invalid Phone number")
            return .invalid
        }
    }
    
}
