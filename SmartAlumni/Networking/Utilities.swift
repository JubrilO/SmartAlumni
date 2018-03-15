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
import RealmSwift

class Utilities {
    
    let realm = try! Realm()
    
    fileprivate struct Constants {
        static let Success = "success"
        static let data = "data"
        static let status = "status"
    }
        
    class func parseOTPFromJSON(json: JSON) -> String? {
        print(json)
        if json["status"].stringValue == "success" {
            return json["data"].stringValue
        }
        else {
            return nil
        }
    }
    
    class func parseUIDFromJSON(json: JSON) -> (String?, String?){
        print(json)
        
        if json["status"].stringValue == "success" {
            let uid = json["data"]["_id"].stringValue
            return(uid, nil)
        }
        else {
            let error = json["err"].stringValue
            return(nil, error)
        }
    }
    
    class func parseUserFromJSON(json: JSON) -> (user: User?, error: Error?) {
        print(json)
        if json["status"].stringValue == "success" {
            let user = User(json: json)
            let jwt = json["data"]["security_token"].stringValue
            try! Locksmith.updateData(data: ["security_token" : jwt], forUserAccount: user!.uid)
            return (user: user, error: nil)
        }
        else {
            let error = json["data"]["err"].stringValue
            return(user: nil, error: StringError(error))
        }
    }
    
    class func parseChatRoomFromJSON(json: JSON) -> (chatRooms: [ChatRoom]?, error: Error?) {
        if json["status"].stringValue == Constants.Success {
            var chatRooms = [ChatRoom]()
            for chatRoomJSON in json["data"].arrayValue {
                let chatRoom = ChatRoom(json: chatRoomJSON)
                chatRooms.append(chatRoom)
            }
            return (chatRooms, nil)
        }
        else {
            let error = json["err"].stringValue
            return(nil, StringError(error))
        }
    }
    
    class func parseMessagesFromJSON(json: JSON) -> (messages: [Message]?, error: Error?) {
        if json["status"].stringValue == Constants.Success {
            var messages = [Message]()
            for  messageJSON in json["data"].arrayValue {
                let message = Message(json: messageJSON )
                messages.append(message)
            }
            return (messages, nil)
        }
        else {
            let error = json["err"].stringValue
            return(nil, StringError(error))
        }
    }
    
    class func parseSchoolsFromJSON(json: JSON) -> (schools: [School]?, error: Error?) {
        if json["status"].stringValue == Constants.Success {
            
            var schools = [School]()
            for schoolJSON in json["data"].arrayValue {
                let school = School(json: schoolJSON)
                schools.append(school)
            }
            return (schools, nil)
        }
            
        else {
            let error = json["err"].stringValue
            return (nil, StringError(error))
        }
    }
    
    class func parseProjectsFromJSON(json: JSON) -> (projects: [Project]?, error: Error?) {
        if json["status"].stringValue == Constants.Success {
            
            var projects = [Project]()
            for projectJSON in json["data"].arrayValue {
                let project = Project(json: projectJSON)
                projects.append(project)
            }
            return (projects, nil)
        }
        else {
            let error = json["err"].stringValue
            return (nil, StringError(error))
        }
    }
    
    class func parseSuccessFromJSON(json: JSON) -> (success: Bool, error: String?) {
        print(json)
        if json["status"].stringValue == Constants.Success {
            return (true, nil)
        }
        else {
            return (false, json["err"].stringValue)
        }
    }
    
    class func parsePollsFromJSON(json: JSON) -> (polls: [Poll]?, error: String?) {
        print(json)
        if json["status"].stringValue == Constants.Success {
            var polls = [Poll]()
            for pollJSON in json["data"].arrayValue {
                let poll = Poll(json: pollJSON)
                polls.append(poll)
            }
            return (polls, nil)
        }
        else {
            let error = json["data"].stringValue
            return (nil, error)
        }
    }
    
    class func generatePollDict(title: String, question: String, options: [Option], startDate: String, duration: Int, visibility: [String : Any]) -> [String : Any] {
        var optionsDict = [[String : Any]]()
        for (index, option) in options.enumerated() {
            let optionDict = ["name" : option.text, "value" : 0, "index" : index+1] as [String: Any]
            optionsDict.append(optionDict)
        }
        var parameters  = [String:Any]()
        let realm = try! Realm()
        if let user = realm.objects(User.self).first {
        parameters = ["name" : title, "creator" : user.uid, "question" : question, "start_date" : startDate, "duration" : duration, "options" : optionsDict, "visibility" : visibility, "status": "ongoing"] as [String : Any]
        }
        return parameters
    }
    
}

struct StringError : LocalizedError {
    var errorDescription: String? { return mMsg }
    var failureReason: String? { return mMsg }
    var recoverySuggestion: String? { return "" }
    var helpAnchor: String? { return "" }

    private var mMsg : String
    
    init(_ description: String)
    {
        mMsg = description
    }
}
