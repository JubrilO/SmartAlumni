//
//  Project.swift
//  SmartAlumni
//
//  Created by Jubril on 3/14/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON

class Project {
    var id = ""
    var title = ""
    var amount: Double = 0
    var status = ""
    var description = ""
    var schoolName = ""
    var set = ""
    var imageURL = ""
    
    required convenience init(json: JSON) {
        self.init()
        self.id = json["_id"].stringValue
        self.title = json["name"].stringValue
        self.amount = json["amount"].doubleValue
        self.description = json["description"].stringValue
        self.status = json["status"].stringValue
        self.imageURL = json["image"].stringValue
        self.schoolName = json["visibility"]["school"]["name"].stringValue
        
    }
}
