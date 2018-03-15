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
        static let Email = "Email"
        static let SignUpStage1 = "SignUpStage1"
        static let SignUpStage2 = "SignUpStage2"
        static let SignUpStage3 = "SignUpStage3"
    }
    
    struct StoryboardIdentifiers {
        static let OTPScene = "OTPScene"
        static let EditProfileScene = "EditProfileScene"
        static let SignUpCompleteScene = "SignUpCompleteScene"
        static let InitialNavScene = "InitialNavScene"
        static let SelectSchoolScene = "SelectSchoolScene"
        static let SelectSetScene = "SelectSetScene"
        static let JoinSetCompletionScene = "JoinSetCompletionScene"
        static let LandingTabBarScene = "LandingTabBarScene"
        static let PollsNavScene = "PollsNavScene"
        static let PollVisibilityScene = "PollVisibilityScene"
        static let PollCompletionScene = "PollCompletionScene"
        static let VisibilityOptionScene = "VisibilityOptionScene"
        static let SelectSchoolCategoryScene = "SelectSchoolCategoryScene"
        static let SelectFacultyScene = "SelectFacultyScene"
        static let WalletLandingScene = "WalletLandingScene"
        static let TransactionDetailScene = "TransactionDetailScene"
        static let MessagesScene = "MessagesScene"
    }
    
    struct StoryboardNames {
        static let JoinSchool = "JoinSchool"
        static let Polls = "Polls"
        static let Wallet = "Wallet"
        static let Landing = "Landing"
    }
    
    struct CellIdentifiers {
        static let SelectSchoolCell = "SelectSchoolCell"
        static let PollCell = "PollCell"
        static let VisibilityCell = "VisibilityCell"
        static let VisibilityOptionCell = "VisibilityOptionCell"
        static let TransactionCell = "TransactionCell"
        static let MessageCell = "messageCell"
        static let ProjectCell = "ProjectCell"
    }
    
    struct  Errors {
        static let InvalidNumber = "You entered an invalid number"
        static let InvalidOTP = "You entered an invalid OTP code"
    }
    
    struct Colors {
        static let borderColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        static let softBlue = UIColor(red: 107/255, green: 163/255, blue: 241/255, alpha: 1.0)
        static let darkGrey = UIColor(red: 78/255, green: 86/255, blue: 95/255, alpha: 1.0)
        
    }
    
    struct PlaceholderImages {
        
        static let AddPhoto = UIImage(named: "photoPlacholder")!
        static let ProfilePicture = UIImage(named: "profilePicture")!
        static let Circle = UIImage(named: "Oval")!
        static let Checkmark = UIImage(named: "checkmark")!
    }
    
    static let SmartAlumniUser = "SmartAlumniUser"
}
