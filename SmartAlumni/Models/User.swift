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
    
    @objc dynamic var uid = ""
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var email = ""
    @objc dynamic var username = ""
    @objc dynamic var phoneNumber = ""
    @objc dynamic var profileImage = ""
    @objc dynamic var notificationToken = ""
    var schoolIds = List<String>()
    var schoolDetailsList = List<SchoolDetails>()
    @objc dynamic var isAdmin = false
    
    required convenience init?(json: JSON) {
        self.init()
        self.uid = json["data"]["_id"].stringValue
        self.email = json["data"]["email"].stringValue
        self.firstName = json["data"]["first_name"].stringValue
        self.lastName = json["data"]["last_name"].stringValue
        self.phoneNumber = json["data"]["phone_number"].stringValue
        self.profileImage = json["data"]["profile_image"].stringValue
        self.notificationToken = json["data"]["notification_token"].stringValue
        self.username = json["data"]["name"].stringValue
        self.isAdmin = json["data"]["is_admin"].boolValue
        
    }
    
    required convenience init(jsonData: JSON) {
        self.init()
        self.uid = jsonData["_id"].stringValue
        self.email = jsonData["email"].stringValue
        self.firstName = jsonData["first_name"].stringValue
        self.lastName = jsonData["last_name"].stringValue
        self.phoneNumber = jsonData["phone_number"].stringValue
        self.profileImage = jsonData["profile_image"].stringValue
        self.notificationToken = jsonData["notification_token"].stringValue
        self.username = jsonData["name"].stringValue
        self.isAdmin = jsonData["is_admin"].boolValue
    }
    
    func toJSON() -> [String:Any] {
        let JSONDict = [ "user" : [
            "_id" : self.uid,
            "email" : self.email,
            "first_name" : self.firstName,
            "last_name" : self.lastName,
            "phone_number" : self.phoneNumber,
            "notification_token" : self.notificationToken,
            "name" : self.username,
            "profile_image" : self.profileImage
            ]
        ]
        return JSONDict
    }
}
