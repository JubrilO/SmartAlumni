//
//  VisibilityOptionPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 11/28/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol VisibilityOptionPresenterInput: VisibilityOptionInteractorOutput {

}

protocol VisibilityOptionPresenterOutput: class {

    func displayData()
}

final class VisibilityOptionPresenter {

    private(set) weak var output: VisibilityOptionPresenterOutput!


    // MARK: - Initializers

    init(output: VisibilityOptionPresenterOutput) {

        self.output = output
    }
}


// MARK: - VisibilityOptionPresenterInput

extension VisibilityOptionPresenter: VisibilityOptionPresenterInput {


    // MARK: - Presentation logic

    func presentData() {
        output.displayData()
    }
}
