//
//  ConversationInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 2/15/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit
import SocketIO
import MessageKit

protocol ConversationInteractorInput: ConversationViewControllerOutput {
    
}

protocol ConversationInteractorOutput {
    
    func presentSomething()
    func presentSocketConnected()
    func presentMessageSent()
    func presentMessages()
    func presentIncomingMessage(message: Message)
    func presentError(error: Error?)
}

final class ConversationInteractor: ConversationViewControllerOutput {
    
    let output: ConversationInteractorOutput
    let worker: ConversationWorker
    
    
    // MARK: - Initializers
    
    init(output: ConversationInteractorOutput, worker: ConversationWorker = ConversationWorker()) {
        
        self.output = output
        self.worker = worker
    }
    
    
    // MARK: - ConversationInteractorInput
    
    var currentSender = Sender(id: "", displayName: "")
    var chatRoom = ChatRoom ()
    
    var messages = [Message]()
    
    func fetchMessages() {
        worker.fetchMessages(chatRoom: chatRoom) {
            messages, error in
            guard let messages = messages else {
                self.output.presentError(error: error)
                return
            }
            self.messages = messages
            self.output.presentMessages()
        }
        connectSocket()
    }
    
    func handleRecievedFromSocket(){
        SocketIOManager.sharedInstance.handleReceiveMessageData() {
            data, ack in
            print("message recieved")
        }
        
    }
    
    func closeConnection() {
        SocketIOManager.sharedInstance.closeConnection()
    }
    
    func connectSocket() {
        SocketIOManager.sharedInstance.establishConnection(schoolID: chatRoom.schoolID, chatRoomID: chatRoom.id) { message, _ in
            guard let message = message else {return}
            if message.messageId != self.messages.last?.messageId {
                self.messages.append(message)
                self.output.presentIncomingMessage(message: message)
            }
        }
    }
    
    func send(textMessage: Message) {
        SocketIOManager.sharedInstance.sendMessage(message: textMessage)
    }
    
    
    // MARK: - Websocket Delegate
    
    
}
