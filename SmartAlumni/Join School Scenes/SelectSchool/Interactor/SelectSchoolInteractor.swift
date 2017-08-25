//
//  SelectSchoolInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 8/24/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol SelectSchoolInteractorInput: SelectSchoolViewControllerOutput {

}

protocol SelectSchoolInteractorOutput {

    func presentSomething()
}

final class SelectSchoolInteractor {

    let output: SelectSchoolInteractorOutput
    let worker: SelectSchoolWorker


    // MARK: - Initializers

    init(output: SelectSchoolInteractorOutput, worker: SelectSchoolWorker = SelectSchoolWorker()) {

        self.output = output
        self.worker = worker
    }
}


// MARK: - SelectSchoolInteractorInput

extension SelectSchoolInteractor: SelectSchoolViewControllerOutput {


    // MARK: - Business logic

    func fetchAllSchools() {

        // TODO: Create some Worker to do the work

        worker.fetchAllSchools()

        // TODO: Pass the result to the Presenter

        output.presentSomething()
    }
}
