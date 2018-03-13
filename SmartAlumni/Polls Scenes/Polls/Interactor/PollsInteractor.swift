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

    func presentPolls()
    func presentError(error: String)
}

final class PollsInteractor: PollsViewControllerOutput {
    var polls = [Poll]()
    var ongoingPolls = [Poll]()
    var completedPolls = [Poll]()
    

    let output: PollsInteractorOutput
    let worker: PollsWorker


    // MARK: - Initializers

    init(output: PollsInteractorOutput, worker: PollsWorker = PollsWorker()) {

        self.output = output
        self.worker = worker
    }


// MARK: - PollsInteractorInput




    // MARK: - Business logic
    
    func fetchPolls() {
        worker.fetchPolls {
            polls, error in
            guard error == nil else {
               self.output.presentError(error: error!)
                return
            }
            if let polls = polls {
                self.completedPolls = polls.filter {$0.status == .completed}.sorted{$0.endDate > $1.endDate}
                self.ongoingPolls = polls.filter {$0.status == .ongoing}.sorted{$0.endDate < $1.endDate}
                self.polls = self.ongoingPolls
                self.output.presentPolls()
            }
        }
    }
    
    func loadOngoingPolls() {
        polls = ongoingPolls
        output.presentPolls()
    }
    
    func loadCompletedPolls() {
        polls = completedPolls
        output.presentPolls()
    }

}
