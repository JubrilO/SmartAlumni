//
//  SignUpInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 8/7/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import PhoneNumberKit
import SwiftValidator

protocol SignUpInteractorInput: SignUpViewControllerOutput {
}

protocol SignUpInteractorOutput {
    
    func presentError(errorMessage: String)
    func presentOTPScene()
}

final class SignUpInteractor: SignUpViewControllerOutput, ValidationDelegate {
    
    
    let output: SignUpInteractorOutput
    let worker: SignUpWorker
    var email: String?
    
    let validator = Validator()
    
    // MARK: - Initializers
    
    init(output: SignUpInteractorOutput, worker: SignUpWorker = SignUpWorker()) {
        
        self.output = output
        self.worker = worker
    }
    
    
    // MARK: - SignUpInteractorInput
    
    func registerTextField(feild: UITextField) {
        validator.registerField(feild, rules: [RequiredRule(), EmailRule(message: "Please enter a valid email address")])
    }
    
    func validate() {
        validator.validate(self)
    }
    
    func validationSuccessful() {
        guard let email = email else {
            print("No email")
            return
        }
        signUpUser(email: email)
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (_, error) in errors {
            output.presentError(errorMessage: error.errorMessage)
        }
    }
    
    
    // MARK: - Business logic
    
    func signUpUser(email: String) {
        
        worker.signUpUser(email: email) {
            errorMessage in
            
            guard errorMessage != nil else {
                
                self.worker.generateOTP(email: email) {
                    otp, error in
                    
                    guard otp != nil else {
                        self.output.presentError(errorMessage: error!)
                        return
                    }
                    
                    UserDefaults.standard.set(otp!, forKey: Constants.UserDefaults.OTP)
                    UserDefaults.standard.set(email, forKey: Constants.UserDefaults.Email)
                    UserDefaults.standard.set(true, forKey: Constants.UserDefaults.SignUpStage1)
                    self.output.presentOTPScene()
                }
                return
            }
            
            self.output.presentError(errorMessage: errorMessage!)
        }
    }
    
}
