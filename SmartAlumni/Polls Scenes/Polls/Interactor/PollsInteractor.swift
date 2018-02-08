//
//  PollsInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 10/27/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol PollsInteractorInput: PollsViewControllerOutput {

}

protocol PollsInteractorOutput {

    func presentSomething()
}

final class PollsInteractor: PollsViewControllerOutput {
    var polls = [Poll]()
    

    let output: PollsInteractorOutput
    let worker: PollsWorker


    // MARK: - Initializers

    init(output: PollsInteractorOutput, worker: PollsWorker = PollsWorker()) {

        self.output = output
        self.worker = worker
    }


// MARK: - PollsInteractorInput




    // MARK: - Business logic

    func doSomething() {

        // TODO: Create some Worker to do the work

        // TODO: Pass the result to the Presenter

        output.presentSomething()
    }
}
