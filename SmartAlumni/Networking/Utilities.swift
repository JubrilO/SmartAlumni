//
//  Utilities.swift
//  SmartAlumni
//
//  Created by Jubril on 8/7/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON

class Utilities {
    
    class func parseOTPFromJSON(json: JSON) -> String? {
        
        if json["status"].stringValue == "success" {
            return json["data"].stringValue
        }
        else {
            return nil
        }
    }
    
    class func parseUIDFromJSON(json: JSON) -> (String?, String?){
        
        if json["status"].stringValue == "success" {
            let jwt = json["data"]["security_token"].stringValue
            let uid = json["data"]["_id"].stringValue
            return(uid, nil)
        }
        else {
            let error = json["data"]["err"].stringValue
            return(nil, error)
        }
    }
    
    class func parseUserFromJSON(json: JSON) -> (user: User?, error: String?) {
        if json["status"].stringValue == "success" {
            let user = User(json: json)
            return (user: user, error: nil)
        }
        else {
            let error = json["data"]["err"].stringValue
            return(user: nil, error: error)
        }
    }
    
}
