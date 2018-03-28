//
//  ChatRoomInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 3/22/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ChatRoomInteractorInput: ChatRoomViewControllerOutput {

}

protocol ChatRoomInteractorOutput {

    func presentSomething()
}

final class ChatRoomInteractor {

    let output: ChatRoomInteractorOutput
    let worker: ChatRoomWorker


    // MARK: - Initializers

    init(output: ChatRoomInteractorOutput, worker: ChatRoomWorker = ChatRoomWorker()) {

        self.output = output
        self.worker = worker
    }
}


// MARK: - ChatRoomInteractorInput

extension ChatRoomInteractor: ChatRoomViewControllerOutput {


    // MARK: - Business logic

    func doSomething() {

        // TODO: Create some Worker to do the work

        worker.doSomeWork()

        // TODO: Pass the result to the Presenter

        output.presentSomething()
    }
}
