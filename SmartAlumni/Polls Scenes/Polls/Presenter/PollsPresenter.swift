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

    func displaySomething(viewModel: PollsViewModel)
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

    func presentSomething() {

        // TODO: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = PollsViewModel()
        output.displaySomething(viewModel: viewModel)
    }
}
