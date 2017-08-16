//
//  OTPPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 8/13/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol OTPPresenterInput: OTPInteractorOutput {

}

protocol OTPPresenterOutput: class {
    
    func presentNextScene()
    func displayError(viewModel: OTPViewModel)
    func displayOTPCopy(copy: String)
}

final class OTPPresenter {

    private(set) weak var output: OTPPresenterOutput!


    // MARK: - Initializers

    init(output: OTPPresenterOutput) {

        self.output = output
    }
}


// MARK: - OTPPresenterInput

extension OTPPresenter: OTPPresenterInput {


    // MARK: - Presentation logic
    
    func presentError() {
        let viewModel = OTPViewModel(errorMessage: Constants.Errors.InvalidOTP)
        output.displayError(viewModel: viewModel)
    }
    
    func presentNextScene() {
        output.presentNextScene()
    }
    
    func displayPhoneNumber(phoneNumber: String?) {
        if let phoneNumber = phoneNumber {
            let copy = "Enter the four digit code we sent to \(phoneNumber)"
        output.displayOTPCopy(copy: copy)
        }
    }
}
