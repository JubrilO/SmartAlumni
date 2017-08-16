//
//  OTPInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 8/13/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol OTPInteractorInput: OTPViewControllerOutput {
    
    var phoneNumber: String? {get set}

}

protocol OTPInteractorOutput {
    
    func presentError()
    func presentNextScene()
    func displayPhoneNumber(phoneNumber: String?)
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
    var phoneNumber: String?
    
    func verifyOTP(otp: String) {
        
        if let generatedOTP = UserDefaults.standard.string(forKey: Constants.UserDefaults.OTP) {
            
            guard generatedOTP == otp else {
                output.presentError()
                return
            }
            
            output.presentNextScene()
        }
        
    }
    
    func fetchPhoneNumber() {
        
        output.displayPhoneNumber(phoneNumber: phoneNumber)
    }

}
