//
//  NewPollPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 11/2/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol NewPollPresenterInput: NewPollInteractorOutput {

}

protocol NewPollPresenterOutput: class {
    func displayPollVisibilityOptions(options: String)
    func dispayError(errorMessage: String?)
    func diplayPollCompletionScene()
}

final class NewPollPresenter {

    private(set) weak var output: NewPollPresenterOutput!


    // MARK: - Initializers

    init(output: NewPollPresenterOutput) {

        self.output = output
    }
}


// MARK: - NewPollPresenterInput

extension NewPollPresenter: NewPollPresenterInput {


    // MARK: - Presentation logic
    
    func presentPollCreationCompleteScene() {
        output.diplayPollCompletionScene()
    }
    
    func presentError(string: String?) {
        output.dispayError(errorMessage: string)
    }
    
    func presentPollVisiblityOptions(string: String) {
        output.displayPollVisibilityOptions(options: string)
    }
    

}
