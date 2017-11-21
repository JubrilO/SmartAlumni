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

    func displaySomething(viewModel: NewPollViewModel)
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

    func presentSomething() {

        // TODO: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = NewPollViewModel()
        output.displaySomething(viewModel: viewModel)
    }
}
