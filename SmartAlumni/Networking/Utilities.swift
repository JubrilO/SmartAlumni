//
//  Utilities.swift
//  SmartAlumni
//
//  Created by Jubril on 8/7/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON
import Locksmith

class Utilities {
    
    fileprivate struct Constants {
        static let Success = "success"
        static let data = "data"
        static let status = "status"
    }
    
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
            let uid = json["data"]["_id"].stringValue
            return(uid, nil)
        }
        else {
            let error = json["err"].stringValue
            return(nil, error)
        }
    }
    
    class func parseUserFromJSON(json: JSON) -> (user: User?, error: String?) {
        
        if json["status"].stringValue == "success" {
            let user = User(json: json)
            let jwt = json["data"]["security_token"].stringValue
            try! Locksmith.updateData(data: ["security_token" : jwt], forUserAccount: user!.uid)
            return (user: user, error: nil)
        }
        else {
            let error = json["data"]["err"].stringValue
            return(user: nil, error: error)
        }
    }
    
    class func parseSchoolsFromJSON(json: JSON) -> (schools: [School]?, error: String?) {
        
        if json["status"].stringValue == Constants.Success{
            
            var schools = [School]()
            for schoolJSON in json["data"].arrayValue {
                let school = School(json: schoolJSON)
                schools.append(school)
            }
            return (schools, nil)
        }
            
        else {
            let error = json["err"].stringValue
            return (nil, error)
        }
    }
    
    class func parseSuccessFromJSON(json: JSON) -> (success: Bool, error: String?){
        if json["status"].stringValue == Constants.Success {
            return (true, nil)
        }
        else {
            return (false, json["err"].stringValue)
        }
    }
    
    class func parsePollsFromJSON(json: JSON) -> (polls: [Poll]?, error: String?) {
        if json["status"].stringValue == Constants.Success {
            var polls = [Poll]()
            for pollJSON in json["data"].arrayValue {
                let poll = Poll(json: pollJSON)
                polls.append(poll)
            }
            return (polls, nil)
        }
        else {
            let error = json["err"].stringValue
            return (nil, error)
        }
    }
    
    class func generatePollDict(title: String, question: String, options: [Option], startDate: String, endDate: String, visibility: [String : Any]) -> [String : Any] {
        var optionsDict = [[String : Any]]()
        for option in options {
            let optionDict = ["name" : option.text, "value" : 0] as [String: Any]
            optionsDict.append(optionDict)
        }
        let parameters = ["name" : title, "question" : question, "start_date" : startDate, "end_date" : endDate, "options" : optionsDict, "visibility" : visibility] as [String : Any]
        return parameters
    }
    
}
