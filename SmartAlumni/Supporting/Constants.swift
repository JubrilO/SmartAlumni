//
//  Constants.swift
//  SmartAlumni
//
//  Created by Jubril on 8/8/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct UserDefaults {
        static let OTP = "OTP"
        static let UID = "UID"
        static let PhoneNumber = "PhoneNumber"
    }
    
    struct StoryboardIdentifiers {
        static let OTPScene = "OTPScene"
        static let EditProfileScene = "EditProfileScene"
        static let SignUpCompleteScene = "SignUpCompleteScene"
        static let InitialNavScene = "InitialNavScene"
        static let SelectSchoolScene = "SelectSchoolScene"
        static let SelectSetScene = "SelectSetScene"
        static let JoinSetCompletionScene = "JoinSetCompletionScene"
    }
    
    struct StoryboardNames {
        static let JoinSchool = "JoinSchool"
    }
    
    struct CellIdentifiers {
        static let SelectSchoolCell = "SelectSchoolCell"
    }
    
    struct  Errors {
        static let InvalidNumber = "You entered an invalid number"
        static let InvalidOTP = "You entered an invalid OTP code"
    }
    
    struct Colors {
        static let borderColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
    }
    
    struct PlaceholderImages {
        
        static let AddPhoto = UIImage(named: "photoPlacholder")!
        static let ProfilePicture = UIImage(named: "profilePicture")!
    }
    
    static let SmartAlumniUser = "SmartAlumniUser"
}
