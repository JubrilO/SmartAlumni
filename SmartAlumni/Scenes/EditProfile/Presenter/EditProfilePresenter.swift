//
//  EditProfilePresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 8/15/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol EditProfilePresenterInput: EditProfileInteractorOutput {

}

protocol EditProfilePresenterOutput: class {
    
    func presentNextScene()
    func displayError(errorMessage: String)
    func displayEmail(email: String)
}

final class EditProfilePresenter {

    private(set) weak var output: EditProfilePresenterOutput!


    // MARK: - Initializers

    init(output: EditProfilePresenterOutput) {

        self.output = output
    }
}


// MARK: - EditProfilePresenterInput

extension EditProfilePresenter: EditProfilePresenterInput {
    
    // MARK: - Presentation logic
    
    func presentUsersEmail(email: String) {
        output.displayEmail(email: email)
    }
    
    func presentNextScene() {
        output.presentNextScene()
    }

    func presentError(errorMessage: String) {
        output.displayError(errorMessage: errorMessage)
    }

}
