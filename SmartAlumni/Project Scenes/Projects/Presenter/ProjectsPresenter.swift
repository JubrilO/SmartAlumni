//
//  ProjectsPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 3/5/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ProjectsPresenterInput: ProjectsInteractorOutput {

}

protocol ProjectsPresenterOutput: class {

    func displaySomething(viewModel: ProjectsViewModel)
}

final class ProjectsPresenter {

    private(set) weak var output: ProjectsPresenterOutput!


    // MARK: - Initializers

    init(output: ProjectsPresenterOutput) {

        self.output = output
    }
}


// MARK: - ProjectsPresenterInput

extension ProjectsPresenter: ProjectsPresenterInput {


    // MARK: - Presentation logic

    func presentSomething() {

        // TODO: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = ProjectsViewModel()
        output.displaySomething(viewModel: viewModel)
    }
}
