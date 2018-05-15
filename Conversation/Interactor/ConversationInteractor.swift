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
            for message in messages {
                switch message.messageContent!.messageType {
                case MessageTypeConstants.image:
                message.data = self.setMessageData(data: message.messageContent!.image!.urlString, contentType: "image", messageIndex: self.messages.count)
                default:
                    message.data = .text(message.content)
                }
                self.messages.append(message)
            }
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
    
    func setMessageData(data: String, contentType: String, messageIndex: Int) -> MessageData {
        if contentType.range(of:"image") != nil {
            let imageView = UIImageView()
            let url = URL(string: data)!
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url, completionHandler: {
                (image, error, cacheType, imageUrl) in
                if (image != nil) {
                    self.reloadMessage(messageIndex, MessageData.photo(image!))
                }
            })
            if (imageView.image != nil) {
                return MessageData.photo(imageView.image!)
            }
            return MessageData.photo(UIImage(named: "messageImagePlaceholder")!)
        } else if contentType.range(of:"video") != nil {
            let url = URL(string: data)!
            return MessageData.video(file: url, thumbnail: UIImage(named: "videoThumbnail")!)
        }
        return MessageData.text(data)
    }
    
    func reloadMessage(_ messageIndex: Int,_ messageData :MessageData) -> Void {
        if messageIndex < messages.count {
            let oldMessage = messages[messageIndex]
            let message = Message()
            message.sender = oldMessage.sender
            message.messageId = oldMessage.messageId
            message.sentDate = oldMessage.sentDate
            message.data = messageData
            messages[messageIndex] = message
            self.output.presentMessages()
            //self.messagesCollectionView.reloadData()
            //self.messagesCollectionView.scrollToBottom()
        }
    }
    
}
