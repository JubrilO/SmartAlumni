//
//  ConversationWorker.swift
//  SmartAlumni
//
//  Created by Jubril on 2/15/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

class ConversationWorker {


    // MARK: - Business Logic

    func fetchMessages(chatRoom: ChatRoom, completionHandler: @escaping ([Message]?, Error?) -> Void) {
        ChatAPI.sharedManager.getMessagesFor(chatroom: chatRoom) {
            messages, error in
            completionHandler(messages, error)
        }
        
    }
}
