//
//  ProjectsInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 3/5/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ProjectsInteractorInput: ProjectsViewControllerOutput {

}

protocol ProjectsInteractorOutput {

    func presentSomething()
}

final class ProjectsInteractor {

    let output: ProjectsInteractorOutput
    let worker: ProjectsWorker


    // MARK: - Initializers

    init(output: ProjectsInteractorOutput, worker: ProjectsWorker = ProjectsWorker()) {

        self.output = output
        self.worker = worker
    }
}


// MARK: - ProjectsInteractorInput

extension ProjectsInteractor: ProjectsViewControllerOutput {


    // MARK: - Business logic

    func doSomething() {

        // TODO: Create some Worker to do the work

        worker.doSomeWork()

        // TODO: Pass the result to the Presenter

        output.presentSomething()
    }
}
