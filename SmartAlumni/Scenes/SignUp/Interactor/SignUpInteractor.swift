//
//  SignUpInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 8/7/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import PhoneNumberKit

protocol SignUpInteractorInput: SignUpViewControllerOutput {
}

protocol SignUpInteractorOutput {
    
    func presentError(errorMessage: String)
    func presentOTPScene()
}

final class SignUpInteractor: SignUpViewControllerOutput {

    let output: SignUpInteractorOutput
    let worker: SignUpWorker
    var phoneNumber: String?

    // MARK: - Initializers

    init(output: SignUpInteractorOutput, worker: SignUpWorker = SignUpWorker()) {

        self.output = output
        self.worker = worker
    }


// MARK: - SignUpInteractorInput

    func validate(textField: PhoneNumberTextField) {
        
        switch textField.validate() {
        
        case .invalid:
            output.presentError(errorMessage: Constants.Errors.InvalidNumber)
        
        case .valid(let phoneNumberRaw):
            phoneNumber = PhoneNumberKit().format(phoneNumberRaw, toType: .international)
            UserDefaults.standard.set(phoneNumber, forKey: Constants.UserDefaults.PhoneNumber)
            signUpUser(phoneNumber: phoneNumberRaw)
        }
    }



    // MARK: - Business logic
    
    func signUpUser(phoneNumber: PhoneNumber) {
        
        worker.signUpUser(phoneNumber: phoneNumber) {
            errorMessage in
            
            guard errorMessage != nil else {
                
                self.worker.generateOTP(phoneNumber: phoneNumber) {
                    otp, error in
                    
                    guard otp != nil else {
                        self.output.presentError(errorMessage: error!)
                        return
                    }
                    
                    UserDefaults.standard.set(otp!, forKey: Constants.UserDefaults.OTP)
                    let phoneFormatted = PhoneNumberKit().format(phoneNumber, toType: .international)
                    UserDefaults.standard.set(phoneFormatted, forKey: Constants.UserDefaults.PhoneNumber)
                    self.output.presentOTPScene()
                }
                return
            }
            
            self.output.presentError(errorMessage: errorMessage!)
        }
    }

}
