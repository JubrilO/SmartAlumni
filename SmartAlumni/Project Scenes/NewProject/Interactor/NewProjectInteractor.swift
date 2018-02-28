//
//  NewProjectInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 2/20/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol NewProjectInteractorInput: NewProjectViewControllerOutput {

}

protocol NewProjectInteractorOutput {

    func presentSomething()
}

final class NewProjectInteractor {

    let output: NewProjectInteractorOutput
    let worker: NewProjectWorker


    // MARK: - Initializers

    init(output: NewProjectInteractorOutput, worker: NewProjectWorker = NewProjectWorker()) {

        self.output = output
        self.worker = worker
    }
}


// MARK: - NewProjectInteractorInput

extension NewProjectInteractor: NewProjectViewControllerOutput {


    // MARK: - Business logic

    func doSomething() {

        // TODO: Create some Worker to do the work

        worker.doSomeWork()

        // TODO: Pass the result to the Presenter

        output.presentSomething()
    }
}
