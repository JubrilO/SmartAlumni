//
//  ChatRoom.swift
//  SmartAlumni
//
//  Created by Jubril on 2/14/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON

class ChatRoom {
    var id = ""
    var name = ""
    var roomType = ""
    var imageURL = ""
    var schoolID = ""
    var lastMessage: Message?
    
    required convenience init(json: JSON) {
        self.init()
        print(json)
        self.id = json["_id"].stringValue
        self.name = json["name"].stringValue
        self.roomType = json["room_type"].stringValue
        self.schoolID = json["school_details"]["school"].stringValue
        let lastMessageJSON = json["last_message"].object
        print("Last Message")
        print(lastMessageJSON)
        self.lastMessage = Message(json: JSON(lastMessageJSON))
    }
    
}
