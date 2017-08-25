//
//  WelcomeInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 8/23/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol WelcomeInteractorInput: WelcomeViewControllerOutput {

}

protocol WelcomeInteractorOutput {

    func presentFirstName(name: String)
}

final class WelcomeInteractor {

    let output: WelcomeInteractorOutput
    let worker: WelcomeWorker


    // MARK: - Initializers

    init(output: WelcomeInteractorOutput, worker: WelcomeWorker = WelcomeWorker()) {

        self.output = output
        self.worker = worker
    }
}


// MARK: - WelcomeInteractorInput

extension WelcomeInteractor: WelcomeViewControllerOutput {


    // MARK: - Business logic

    func getFirstName() {

        // TODO: Create some Worker to do the work

        if let firstName = worker.getFirstName() {
            output.presentFirstName(name: firstName)
        }
    }
}
