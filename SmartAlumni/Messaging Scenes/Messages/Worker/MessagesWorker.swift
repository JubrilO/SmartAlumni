//
//  MessagesWorker.swift
//  SmartAlumni
//
//  Created by Jubril on 12/11/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

class MessagesWorker {


    // MARK: - Business Logic

    func fetchChatRooms(completionHandler: @escaping ([ChatRoom]? , Error?) -> ()) {
        ChatAPI.sharedManager.getAllChatRooms {
            chatRooms, error in
            completionHandler(chatRooms, error)
        }
    }
}
