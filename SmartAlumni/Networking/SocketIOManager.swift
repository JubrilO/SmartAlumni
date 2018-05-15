//
//  SocketIOManager.swift
//  SmartAlumni
//
//  Created by Jubril on 2/17/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import SocketIO
import RealmSwift
import SwiftyJSON

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    typealias SocketResponse = (Message?, Error?) -> ()
    let defaultNotificationCenter = NotificationCenter.default
    
    struct Event {
        static let NewUserToServer = "new_user_to_server"
        static let NewUserToClient = "new_user_to_client"
        static let EnterRoomToServer = "enter_room_to_server"
        static let EnterRoomToClient = "enter_room_to_client"
        static let MessageToServer = "message_to_server"
        static let MessageToClient = "message_to_client"
    }
    
    let manager =  SocketManager(socketURL: URL(string: "https://www.smartalumni.ng")!, config: [.log(true)])
    let socket: SocketIOClient
    
    override init() {
        self.socket = manager.defaultSocket
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(handleReceiveMessageData), name: .messageToClient, object: nil)
    }
    
    deinit {
        socket.disconnect()
        socket.removeAllHandlers()
    }
    
    func establishConnection(schoolID: String, chatRoomID: String, completionHandler: @escaping (Message?, Error?) -> ()) {
        let user = try! Realm().objects(User.self)[0]
        
        socket.on(clientEvent: .connect) { data, ack in
            let dict: [String: Any] = ["user" : ["_id" : user.uid, "email" : user.email], "school_id" : schoolID]
            self.socket.emit(Event.NewUserToServer, dict.jsonString()!)
        }
        
        socket.on(Event.NewUserToClient) { data, ack in
            print("DATA ON  \(data[0])")
            self.socket.emit(Event.EnterRoomToServer, ["user_id" : user.uid, "room_id" : chatRoomID].jsonString()!)
        }
        
        socket.on(Event.EnterRoomToClient) {data, ack in
            print("Data enterRoomToClient: \(data[0])")
        }
        
        socket.on(Event.MessageToClient) { data, ack in
                print("Data Message to client: \(data[0])")
            let jsondata = data[0]
            let json = JSON(jsondata)
            let message =  Message(json: json)
            if message.messageId != "" {
                completionHandler(message, nil)
            }
        }
        
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
        socket.removeAllHandlers()
    }
    
    @objc func handleReceiveMessageData(completionHandler: NormalCallback ) {
        
    }
    
    func sendMessage(message: Message) {
        var messageDict = message.toJsonDict()
        messageDict.merge(["room_id" : message.chatroomID]){ (current, _) in current }
        if let messageStringJSON = messageDict.jsonString() {
            socket.emit(Event.MessageToServer, messageStringJSON)
        }
    }
    

}
