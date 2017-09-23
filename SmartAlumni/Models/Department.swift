//
//  Department.swift
//  SmartAlumni
//
//  Created by Jubril on 9/22/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON

class Department {
    var id = ""
    var name = ""
    
    required convenience init(json: JSON) {
        self.init()
        self.id = json["_id"].stringValue
        self.name = json["name"].stringValue
    }
}
