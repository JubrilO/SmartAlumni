//
//  Bank.swift
//  SmartAlumni
//
//  Created by Jubril on 4/9/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON

class Bank {
    var name = ""
    var id = ""
    
    required convenience init(json: JSON) {
        self.init()
        self.id = json["_id"].stringValue
        self.name = json["name"].stringValue
    }
}
