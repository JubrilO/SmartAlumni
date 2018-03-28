//
//  ChatAPI.swift
//  SmartAlumni
//
//  Created by Jubril on 2/14/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class ChatAPI {
    static let sharedManager = ChatAPI()
    
    func getAllChatRooms(completionHander: @escaping ([ChatRoom]?, Error?) -> Void) {
        let realm = try! Realm()
        guard let user = realm.objects(User.self).first else {
            return
        }
        let parameters = ["_id" : user.uid]
        Alamofire.request(APIConstants.UserChatRoomsURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
            response in
            
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {
                    return
                }
                let chatRoomsTuple = Utilities.parseChatRoomFromJSON(json: JSON(jsonData))
                completionHander(chatRoomsTuple.chatRooms, chatRoomsTuple.error)
            case .failure(let error):
                print(error)
                completionHander(nil, error)
            }
        }
    }
    
    func createDirectMessageChatRoom(senderID: String, receiverID: String, schoolID: String, completionHandler: (Bool, Error?) -> ()) {
        let parameters: [String:Any] = ["sender_id" : senderID, "receiver_id": receiverID, "school_id" : schoolID]
        
        Alamofire.request(APIConstants.CreateDmURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {
                    return
                }
                
            case .failure(let error):
                print(error)
            }
        }

    }
    
    func createGroupChatRoom(name: String, schoolID: String, userID: String, members: [String], completionHandler: (Bool, Error?) -> ()) {
        let parameters: [String:Any] = ["name" : name, "school_id" : schoolID, "user_id" : userID, "members" : members]
        Alamofire.request(APIConstants.CreateGroupURL, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {return}
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMessagesFor(chatroom: ChatRoom, completionHandler: @escaping ([Message]?, Error?) -> Void) {
        Alamofire.request(APIConstants.GetMessagesURL, method: .post, parameters: ["_id" : chatroom.id], encoding: JSONEncoding.default).responseJSON {
            response in
            
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {
                    return
                }
                let messagesTuple = Utilities.parseMessagesFromJSON(json: JSON(jsonData))
                completionHandler(messagesTuple.messages, messagesTuple.error)
            case .failure(let error):
                print(error)
                completionHandler(nil, error)
            }
        }
    }
}

