//
//  PollVisibilityPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 11/23/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol PollVisibilityPresenterInput: PollVisibilityInteractorOutput {
}

protocol PollVisibilityPresenterOutput: class {
    func displaySchools()
    func displayFaculties()
    func displayDepartments()
}

final class PollVisibilityPresenter {

    private(set) weak var output: PollVisibilityPresenterOutput!


    // MARK: - Initializers

    init(output: PollVisibilityPresenterOutput) {

        self.output = output
    }
}


// MARK: - PollVisibilityPresenterInput

extension PollVisibilityPresenter: PollVisibilityPresenterInput {
   
    // MARK: - Presentation logic
    
    func presentSchools() {
        output.displaySchools()
    }
    
    func presentFaculties() {
        output.displayFaculties()
    }
    
    func presentDepartments() {
        output.displayDepartments()
    }

}
