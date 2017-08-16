//
//  User.swift
//  SmartAlumni
//
//  Created by Jubril on 8/16/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    
    var uid: String
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    
    init(json: JSON) {
        
        self.uid = json["data"]["_id"].stringValue
        self.email = json["data"]["phone_number"].stringValue
        self.firstName = json["data"]["first_name"].stringValue
        self.lastName = json["data"]["last_name"].stringValue
        self.phoneNumber = json["data"]["phone_number"].stringValue
    }
}
