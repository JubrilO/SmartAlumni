//
//  TransactionDetailInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 2/9/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol TransactionDetailInteractorInput: TransactionDetailViewControllerOutput {

}

protocol TransactionDetailInteractorOutput {

    func presentSomething()
}

final class TransactionDetailInteractor {

    let output: TransactionDetailInteractorOutput
    let worker: TransactionDetailWorker


    // MARK: - Initializers

    init(output: TransactionDetailInteractorOutput, worker: TransactionDetailWorker = TransactionDetailWorker()) {

        self.output = output
        self.worker = worker
    }
}


// MARK: - TransactionDetailInteractorInput

extension TransactionDetailInteractor: TransactionDetailViewControllerOutput {


    // MARK: - Business logic

    func doSomething() {

        // TODO: Create some Worker to do the work

        worker.doSomeWork()

        // TODO: Pass the result to the Presenter

        output.presentSomething()
    }
}
