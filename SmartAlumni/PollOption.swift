//
//  PollOption.swift
//  SmartAlumni
//
//  Created by Jubril on 9/25/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class PollOption: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var numberOfVotes = 0
    @objc dynamic var index = 0
    
    required convenience init(json: JSON) {
        self.init()
        self.id = json["_id"].stringValue
        self.name = json["name"].stringValue
        self.numberOfVotes = json["value"].intValue
        self.index = json["index"].intValue
    }
}
