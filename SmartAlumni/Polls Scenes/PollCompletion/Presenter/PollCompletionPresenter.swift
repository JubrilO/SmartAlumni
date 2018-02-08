//
//  PollCompletionPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 11/28/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol PollCompletionPresenterInput: PollCompletionInteractorOutput {

}

protocol PollCompletionPresenterOutput: class {

    func displaySomething(viewModel: PollCompletionViewModel)
}

final class PollCompletionPresenter {

    private(set) weak var output: PollCompletionPresenterOutput!


    // MARK: - Initializers

    init(output: PollCompletionPresenterOutput) {

        self.output = output
    }
}


// MARK: - PollCompletionPresenterInput

extension PollCompletionPresenter: PollCompletionPresenterInput {


    // MARK: - Presentation logic

    func presentSomething() {

        // TODO: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = PollCompletionViewModel()
        output.displaySomething(viewModel: viewModel)
    }
}
