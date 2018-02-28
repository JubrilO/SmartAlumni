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

    func displaySomething(viewModel: NewProjectViewModel)
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


    // MARK: - Presentation logic

    func presentSomething() {

        // TODO: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = NewProjectViewModel()
        output.displaySomething(viewModel: viewModel)
    }
}
