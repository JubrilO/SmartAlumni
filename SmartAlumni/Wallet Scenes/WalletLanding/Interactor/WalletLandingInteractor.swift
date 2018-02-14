//
//  WalletLandingInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 2/9/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol WalletLandingInteractorInput: WalletLandingViewControllerOutput {

}

protocol WalletLandingInteractorOutput {

    func presentSomething()
}

final class WalletLandingInteractor {

    let output: WalletLandingInteractorOutput
    let worker: WalletLandingWorker


    // MARK: - Initializers

    init(output: WalletLandingInteractorOutput, worker: WalletLandingWorker = WalletLandingWorker()) {

        self.output = output
        self.worker = worker
    }
}


// MARK: - WalletLandingInteractorInput

extension WalletLandingInteractor: WalletLandingViewControllerOutput {


    // MARK: - Business logic

    func doSomething() {

        // TODO: Create some Worker to do the work

        worker.doSomeWork()

        // TODO: Pass the result to the Presenter

        output.presentSomething()
    }
}
