//
//  WelcomePresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 8/23/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol WelcomePresenterInput: WelcomeInteractorOutput {

}

protocol WelcomePresenterOutput: class {

    func displayFirstName(viewModel: WelcomeViewModel)
}

final class WelcomePresenter {

    private(set) weak var output: WelcomePresenterOutput!


    // MARK: - Initializers

    init(output: WelcomePresenterOutput) {

        self.output = output
    }
}


// MARK: - WelcomePresenterInput

extension WelcomePresenter: WelcomePresenterInput {


    // MARK: - Presentation logic

    func presentFirstName(name: String) {


        let viewModel = WelcomeViewModel(firstName: name)
        output.displayFirstName(viewModel: viewModel)
    }
}
