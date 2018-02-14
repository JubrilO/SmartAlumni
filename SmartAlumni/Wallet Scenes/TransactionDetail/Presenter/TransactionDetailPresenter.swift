//
//  TransactionDetailPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 2/9/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol TransactionDetailPresenterInput: TransactionDetailInteractorOutput {

}

protocol TransactionDetailPresenterOutput: class {

    func displaySomething(viewModel: TransactionDetailViewModel)
}

final class TransactionDetailPresenter {

    private(set) weak var output: TransactionDetailPresenterOutput!


    // MARK: - Initializers

    init(output: TransactionDetailPresenterOutput) {

        self.output = output
    }
}


// MARK: - TransactionDetailPresenterInput

extension TransactionDetailPresenter: TransactionDetailPresenterInput {


    // MARK: - Presentation logic

    func presentSomething() {

        // TODO: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = TransactionDetailViewModel()
        output.displaySomething(viewModel: viewModel)
    }
}
