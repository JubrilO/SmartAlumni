//
//  SignUpWorker.swift
//  SmartAlumni
//
//  Created by Jubril on 8/7/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import PhoneNumberKit

class SignUpWorker {


    // MARK: - Business Logic
    
    
    func signUpUser(email: String, completionHandler: @escaping (String?) -> () ) {
        UserAPI.sharedManager.signUpUser(email: email) {
           _ , errorMessage in
            guard errorMessage != nil else {
                completionHandler(nil)
                return
            }
            completionHandler(errorMessage)
        }
    }

    func generateOTP(email: String, completionHandler: @escaping (String?, String?) -> () ) {
        
        //let phoneNumberString = PhoneNumberKit().format(phoneNumber, toType: .e164)
        UserAPI.sharedManager.GenerateOTP(email: email) {
            otp, error in
            completionHandler(otp, error?.localizedDescription)
        } 
    }
}
