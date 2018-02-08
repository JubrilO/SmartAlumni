//
//  OTPWorker.swift
//  SmartAlumni
//
//  Created by Jubril on 8/13/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

class OTPWorker {
    
    func resendOTP(completionHandler: @escaping (String?, Error?) -> ()) {
        if let userEmail = UserDefaults.standard.string(forKey: Constants.UserDefaults.Email) {
            UserAPI.sharedManager.GenerateOTP(email: userEmail) {
                otp, error in
                completionHandler(otp, error)
            }
        }
    }
    
}
