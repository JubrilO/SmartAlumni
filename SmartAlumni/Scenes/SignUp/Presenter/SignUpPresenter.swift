//
//  SignUpPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 8/7/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol SignUpPresenterInput: SignUpInteractorOutput {

}

protocol SignUpPresenterOutput: class {

    func displayError(viewModel: SignUpViewModel)
    func presentOTPScene(user: User?)
}

final class SignUpPresenter {

    private(set) weak var output: SignUpPresenterOutput!


    // MARK: - Initializers

    init(output: SignUpPresenterOutput) {

        self.output = output
    }
}


// MARK: - SignUpPresenterInput

extension SignUpPresenter: SignUpPresenterInput {
    
    // MARK: - Presentation logic
    
    func presentError(errorMessage: String) {
        let viewModel = SignUpViewModel(errorMessage: errorMessage)
        output.displayError(viewModel: viewModel)
        
    }
    
    func presentOTPScene(user: User?) {
        output.presentOTPScene(user: user)
    }
    
}
