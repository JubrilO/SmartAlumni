//
//  FundProjectPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 3/16/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol FundProjectPresenterInput: FundProjectInteractorOutput {

}

protocol FundProjectPresenterOutput: class {

    func displaySomething(viewModel: FundProjectViewModel)
}

final class FundProjectPresenter {

    private(set) weak var output: FundProjectPresenterOutput!


    // MARK: - Initializers

    init(output: FundProjectPresenterOutput) {

        self.output = output
    }
}


// MARK: - FundProjectPresenterInput

extension FundProjectPresenter: FundProjectPresenterInput {


    // MARK: - Presentation logic

    func presentError(string: String) {
        
    }
}
