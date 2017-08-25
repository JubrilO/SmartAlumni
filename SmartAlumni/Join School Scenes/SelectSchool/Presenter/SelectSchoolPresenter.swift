//
//  SelectSchoolPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 8/24/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol SelectSchoolPresenterInput: SelectSchoolInteractorOutput {

}

protocol SelectSchoolPresenterOutput: class {

    func displaySomething(viewModel: SelectSchoolViewModel)
}

final class SelectSchoolPresenter {

    private(set) weak var output: SelectSchoolPresenterOutput!


    // MARK: - Initializers

    init(output: SelectSchoolPresenterOutput) {

        self.output = output
    }
}


// MARK: - SelectSchoolPresenterInput

extension SelectSchoolPresenter: SelectSchoolPresenterInput {


    // MARK: - Presentation logic

    func presentSomething() {

        // TODO: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = SelectSchoolViewModel()
        output.displaySomething(viewModel: viewModel)
    }
}
