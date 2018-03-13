//
//  PollsPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 10/27/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol PollsPresenterInput: PollsInteractorOutput {

}

protocol PollsPresenterOutput: class {

    func displayPolls()
    func displayError(error: String)
}

final class PollsPresenter {

    private(set) weak var output: PollsPresenterOutput!


    // MARK: - Initializers

    init(output: PollsPresenterOutput) {

        self.output = output
    }
}


// MARK: - PollsPresenterInput

extension PollsPresenter: PollsPresenterInput {


    // MARK: - Presentation logic

    func presentPolls() {
        output.displayPolls()
    }
    
    func presentError(error: String) {
        output.displayError(error: error)
    }
}
