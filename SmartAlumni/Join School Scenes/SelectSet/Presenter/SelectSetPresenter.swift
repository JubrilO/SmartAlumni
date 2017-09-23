//
//  SelectSetPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 8/29/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol SelectSetPresenterInput: SelectSetInteractorOutput {

}

protocol SelectSetPresenterOutput: class {

    func displayOptions(options: [String])
    func displayJoinSchoolCompletion()
    func displayError(errorMessage: String)
}

final class SelectSetPresenter {

    private(set) weak var output: SelectSetPresenterOutput!


    // MARK: - Initializers

    init(output: SelectSetPresenterOutput) {

        self.output = output
    }
}


// MARK: - SelectSetPresenterInput

extension SelectSetPresenter: SelectSetPresenterInput {


    // MARK: - Presentation logic

    
    func  presentOptions(options: [String]) {
        output.displayOptions(options: options)
    }
    
    func presentJoinSchoolCompletion() {
        output.displayJoinSchoolCompletion()
    }
    
    func presentError(errorMessage: String?) {
        if let errorMessage = errorMessage {
            output.displayError(errorMessage: errorMessage)
        }
        else {
            output.displayError(errorMessage: "Unknown error")
        }
    }
}
