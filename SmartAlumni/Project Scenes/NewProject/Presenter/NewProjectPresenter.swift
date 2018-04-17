//
//  NewProjectPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 2/20/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol NewProjectPresenterInput: NewProjectInteractorOutput {

}

protocol NewProjectPresenterOutput: class {
    func displayError(_ string: String?)
    func displaySuccessScreen()
}

final class NewProjectPresenter {

    private(set) weak var output: NewProjectPresenterOutput!


    // MARK: - Initializers

    init(output: NewProjectPresenterOutput) {

        self.output = output
    }
}


// MARK: - NewProjectPresenterInput

extension NewProjectPresenter: NewProjectPresenterInput {
    func presentSomething() {
        
    }
    


    // MARK: - Presentation logic
    
    func presentError(string: String?) {
        output.displayError(string)
    }
    
    func presentSuccessScreen() {
        output.displaySuccessScreen()
    }

}
