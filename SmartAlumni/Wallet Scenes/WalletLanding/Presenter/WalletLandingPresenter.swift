//
//  WalletLandingPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 2/9/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol WalletLandingPresenterInput: WalletLandingInteractorOutput {

}

protocol WalletLandingPresenterOutput: class {

    func displaySomething(viewModel: WalletLandingViewModel)
}

final class WalletLandingPresenter {

    private(set) weak var output: WalletLandingPresenterOutput!


    // MARK: - Initializers

    init(output: WalletLandingPresenterOutput) {

        self.output = output
    }
}


// MARK: - WalletLandingPresenterInput

extension WalletLandingPresenter: WalletLandingPresenterInput {


    // MARK: - Presentation logic

    func presentSomething() {

        // TODO: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = WalletLandingViewModel()
        output.displaySomething(viewModel: viewModel)
    }
}
