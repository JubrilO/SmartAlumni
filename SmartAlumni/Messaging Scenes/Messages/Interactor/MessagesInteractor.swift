//
//  MessagesInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 12/11/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol MessagesInteractorInput: MessagesViewControllerOutput {

}

protocol MessagesInteractorOutput {

    func presentSomething()
}

final class MessagesInteractor {

    let output: MessagesInteractorOutput
    let worker: MessagesWorker


    // MARK: - Initializers

    init(output: MessagesInteractorOutput, worker: MessagesWorker = MessagesWorker()) {

        self.output = output
        self.worker = worker
    }
}


// MARK: - MessagesInteractorInput

extension MessagesInteractor: MessagesViewControllerOutput {


    // MARK: - Business logic

    func doSomething() {

        // TODO: Create some Worker to do the work

        worker.doSomeWork()

        // TODO: Pass the result to the Presenter

        output.presentSomething()
    }
}
