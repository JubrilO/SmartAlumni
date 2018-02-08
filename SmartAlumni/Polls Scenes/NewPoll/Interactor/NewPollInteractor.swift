//
//  NewPollInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 11/2/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol NewPollInteractorInput: NewPollViewControllerOutput {

}

protocol NewPollInteractorOutput {

    func presentSomething()
}

final class NewPollInteractor {

    let output: NewPollInteractorOutput
    let worker: NewPollWorker


    // MARK: - Initializers

    init(output: NewPollInteractorOutput, worker: NewPollWorker = NewPollWorker()) {

        self.output = output
        self.worker = worker
    }
}


// MARK: - NewPollInteractorInput

extension NewPollInteractor: NewPollViewControllerOutput {
    
    // MARK: - Business logic
    
    func displayError() {
        
    }
    
    func createPoll(title: String, question: String, options: [Option], timeInterval: String, visibility: String) {

    }
}
