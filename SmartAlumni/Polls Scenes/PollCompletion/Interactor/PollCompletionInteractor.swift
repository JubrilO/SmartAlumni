//
//  PollCompletionInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 11/28/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol PollCompletionInteractorInput: PollCompletionViewControllerOutput {

}

protocol PollCompletionInteractorOutput {

    func presentSomething()
}

final class PollCompletionInteractor {

    let output: PollCompletionInteractorOutput
    let worker: PollCompletionWorker


    // MARK: - Initializers

    init(output: PollCompletionInteractorOutput, worker: PollCompletionWorker = PollCompletionWorker()) {

        self.output = output
        self.worker = worker
    }
}


// MARK: - PollCompletionInteractorInput

extension PollCompletionInteractor: PollCompletionViewControllerOutput {


    // MARK: - Business logic

    func doSomething() {

        // TODO: Create some Worker to do the work

        worker.doSomeWork()

        // TODO: Pass the result to the Presenter

        output.presentSomething()
    }
}
