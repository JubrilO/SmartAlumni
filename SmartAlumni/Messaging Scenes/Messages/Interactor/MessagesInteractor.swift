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

    func presentError(errorString: String?)
    func presentChatRooms()
}

final class MessagesInteractor: MessagesViewControllerOutput {

    let output: MessagesInteractorOutput
    let worker: MessagesWorker
    var chatRooms = [ChatRoom]()


    // MARK: - Initializers

    init(output: MessagesInteractorOutput, worker: MessagesWorker = MessagesWorker()) {

        self.output = output
        self.worker = worker
    }


// MARK: - MessagesInteractorInput



    // MARK: - Business logic

    func fetchChatRooms() {
        worker.fetchChatRooms() {
            chatRooms, error in
            guard let chatRooms = chatRooms else {
                self.output.presentError(errorString: error?.localizedDescription)
                return
            }
            self.chatRooms = chatRooms
            self.output.presentChatRooms()
        }
    }
}
