//
//  User.swift
//  SmartAlumni
//
//  Created by Jubril on 8/16/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class User: Object {
    
    dynamic var uid = ""
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var email = ""
    dynamic var phoneNumber = ""
    
    required convenience init?(json: JSON) {
        self.init()
        self.uid = json["data"]["_id"].stringValue
        self.email = json["data"]["phone_number"].stringValue
        self.firstName = json["data"]["first_name"].stringValue
        self.lastName = json["data"]["last_name"].stringValue
        self.phoneNumber = json["data"]["phone_number"].stringValue
    }
}
