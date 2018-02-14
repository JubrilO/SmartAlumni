//
//  Message.swift
//  SmartAlumni
//
//  Created by Jubril on 2/14/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON

class Message {
    var user: String?
   var content = ""
    var timeStamp: Date?
   var type = ""
    
    required convenience init(json: JSON) {
        self.init()
        self.user = json["user"].string
        self.content = json["message"].stringValue
        let timeSinceEpochDouble = json["timestamp"].doubleValue
        let timeSinceEpoch = TimeInterval(floatLiteral: timeSinceEpochDouble)
        print("time since Epoch: \(timeSinceEpoch)")
        self.timeStamp = Date(timeIntervalSince1970: timeSinceEpoch)
        self.type = json["type"].stringValue
   }
}
