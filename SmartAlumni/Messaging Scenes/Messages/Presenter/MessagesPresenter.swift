//
//  MessagesPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 12/11/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol MessagesPresenterInput: MessagesInteractorOutput {

}

protocol MessagesPresenterOutput: class {

    func displaySomething(viewModel: MessagesViewModel)
}

final class MessagesPresenter {

    private(set) weak var output: MessagesPresenterOutput!


    // MARK: - Initializers

    init(output: MessagesPresenterOutput) {

        self.output = output
    }
}


// MARK: - MessagesPresenterInput

extension MessagesPresenter: MessagesPresenterInput {


    // MARK: - Presentation logic

    func presentSomething() {

        // TODO: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = MessagesViewModel()
        output.displaySomething(viewModel: viewModel)
    }
}
