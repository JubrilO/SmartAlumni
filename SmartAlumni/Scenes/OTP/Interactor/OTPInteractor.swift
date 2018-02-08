//
//  OTPInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 8/13/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol OTPInteractorInput: OTPViewControllerOutput {
    
    //var email: String? {get set}

}

protocol OTPInteractorOutput {
    
    func presentError(errorMessage: String?)
    func presentNextScene()
    func displayEmail(email: String?)
}


final class OTPInteractor: OTPViewControllerOutput {
    
    

    let output: OTPInteractorOutput
    let worker: OTPWorker

    // MARK: - Initializers

    init(output: OTPInteractorOutput, worker: OTPWorker = OTPWorker()) {

        self.output = output
        self.worker = worker
    }

    // MARK: - Business logic
    var email: String?
    
    func verifyOTP(otp: String) {
        
        if let generatedOTP = UserDefaults.standard.string(forKey: Constants.UserDefaults.OTP) {
            
            guard generatedOTP == otp else {
                output.presentError(errorMessage: Constants.Errors.InvalidOTP )
                return
            }
            UserDefaults.standard.set(false, forKey: Constants.UserDefaults.SignUpStage1)
            UserDefaults.standard.set(true, forKey: Constants.UserDefaults.SignUpStage2)
            output.presentNextScene()
        }
        
    }
    
    func fetchPhoneNumber() {
        let email = UserDefaults.standard.string(forKey: Constants.UserDefaults.Email)
        output.displayEmail(email: email)
    }
    
    func resendOTP() {
        worker.resendOTP {
            otp, error in
            guard error == nil else {
                self.output.presentError(errorMessage: error?.localizedDescription)
                return
            }
            if let otp = otp {
                UserDefaults.standard.set(otp, forKey: Constants.UserDefaults.OTP)
            }
        }
    }

}
