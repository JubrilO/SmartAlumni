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
}

