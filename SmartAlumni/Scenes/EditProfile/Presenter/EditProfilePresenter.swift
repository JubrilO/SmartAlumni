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

    func displaySomething(viewModel: EditProfileViewModel)
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

    func presentSomething() {

        // TODO: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = EditProfileViewModel()
        output.displaySomething(viewModel: viewModel)
    }
}
