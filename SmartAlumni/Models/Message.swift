//
//  Message.swift
//  SmartAlumni
//
//  Created by Jubril on 2/14/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON
import MessageKit

class Message: MessageType {
    
    fileprivate struct MessageTypeConstants {
        static let text = "TYPE_TEXT"
        static let image = "TYPE_IMAGE"
        static let document = "TYPE_DOCUMENT"
        static let contact = "TYPE_CONTACT"
        static let admin = "TYPE_ADMIN"
        static let error = "TYPE_ERROR"
    }
    
    enum MessageType {
        case text
        case image(imageurl: String)
        case document(name: String, size: String, url: String)
        case contact(name: String, email: String, phone: String)
        case admin(text: String)
        case error
    }
    
    var messageId = ""
    var user = ""
    var content = ""
    var chatroomID = ""
    var data: MessageData = .text("")
    var sender = Sender(id: "", displayName: "")
    var sentDate = Date()
    var type: MessageType = .text
    
    required convenience init(json: JSON) {
        self.init()
        self.user = json["user"].stringValue
        self.chatroomID = json["room"].stringValue
        self.messageId = json["messageid"].stringValue
        let text = json["message"].stringValue
        if json["user"].exists() {
            let user = User(jsonData: json["user"])
            self.sender = Sender(id: user.uid, displayName: user.username)
        }
        self.content = text
        let epochDouble = json["timestamp"].doubleValue
        self.sentDate = parseDateFrom(epoch: epochDouble)
        let messageType = parseMessageTypeFrom(json: json)
        self.type = messageType
        switch type {
        case .text:
            self.data = .text(text)
        case .image(let url):
            let url = URL(string: url)!
            self.data = .photo(UIImage())
            if let data = try? Data(contentsOf: url){
                //guard let image = UIImage(data: data) else {return}
            }
        case .contact(let name, let email, let phone):
            print("")
        case .admin:
            self.content = ""
        default:
            break
        }
    }
    
    convenience init(sender: User, text: String, type: Message.MessageType, messageID: String, chatRoomID: String) {
        self.init()
        self.user = sender.uid
        self.content = text
        self.type = type
        self.chatroomID = chatRoomID
        self.sender = Sender(id: sender.uid, displayName: sender.username)
        switch type {
        case .text:
            self.data = .text(text)
        default:
            break
        }
        self.messageId = messageID
        self.sentDate = Date()
    }
    
    convenience init(sender: User, image: UIImage, type: Message.MessageType, messageID: String, chatRoomID: String) {
        self.init()
        self.user = sender.uid
        self.content = ""
        self.type = type
        self.chatroomID = chatRoomID
        switch type {
        case .text:
            self.data = .text("")
        case .image:
            self.data = .photo(image)
        default:
            break
        }
        self.sender = Sender(id: sender.uid, displayName: sender.username)
        self.messageId = messageID
        self.sentDate = Date()
    }
    
    func toJsonDict() -> [String : Any] {
        var jsonDict = [String : Any]()
        
        switch self.type {
        case .text:
            jsonDict = ["message" : [
                "timestamp" : Int(self.sentDate.timeIntervalSince1970),
                "message" : self.content,
                "messageid" : self.messageId,
                "type" : MessageTypeConstants.text,
                "user" : self.user,
                "room" : self.chatroomID
                ]
            ]
            return jsonDict
            
        case .image(imageurl: let url):
            jsonDict = ["message" : [
                "timestamp" : Int(self.sentDate.timeIntervalSince1970),
                "message" : self.content,
                "messageid" : self.messageId,
                "type" : MessageTypeConstants.image,
                "user" : self.user,
                "room" : self.chatroomID,
                "image" : ["remote_url" : url]
                ]
            ]
            return jsonDict
            
        case .contact(name: let cnName, email: let cnEmail, phone: let cnPhone):
            jsonDict = ["message" : [
                "timestamp" : Int(self.sentDate.timeIntervalSince1970),
                "message" : self.content,
                "messageid" : self.messageId,
                "type" : MessageTypeConstants.contact,
                "user" : self.user,
                "room" : self.chatroomID,
                "contact" : [
                    "email" : cnEmail,
                    "name" : cnName,
                    "phone" : cnPhone ]
                ]
            ]
            return jsonDict
            
        case .document(name: let docname, size: let docsize, url: let docurl):
            jsonDict = ["message" : [
                "timestamp" : Int(self.sentDate.timeIntervalSince1970),
                "message" : self.content,
                "messageid" : self.messageId,
                "type" : MessageTypeConstants.document,
                "user" : self.user,
                "room" : self.chatroomID,
                "document" : [
                    "name" : docname,
                    "size" : docsize,
                    "remote_url" : docurl ]
                ]
            ]
            return jsonDict
            
        default:
            return jsonDict
        }
    }
    
    private func parseDateFrom(epoch: Double) -> Date {
        let timeSinceEpoch = TimeInterval(floatLiteral: epoch)
        return Date(timeIntervalSince1970: timeSinceEpoch)
    }
    
    private func parseMessageTypeFrom(json: JSON) -> MessageType {
        let typeString = json["type"].stringValue
        
        switch typeString {
            
        case MessageTypeConstants.text:
            return .text
            
        case MessageTypeConstants.contact:
            let name = json["contact"]["name"].stringValue
            let email = json["contact"]["email"].stringValue
            let phone = json["contact"]["phone"].stringValue
            return .contact(name: name, email: email, phone: phone)
            
        case MessageTypeConstants.document:
            let fileName = json["document"]["name"].stringValue
            let fileSize = json["document"]["size"].stringValue
            let fileURL = json["document"]["remote_url"].stringValue
            return .document(name: fileName, size: fileSize, url: fileURL)
            
        case MessageTypeConstants.image:
            let imageURL = json["image"]["remote_url"].stringValue
            return .image(imageurl: imageURL)
            
        case MessageTypeConstants.admin:
            return .admin(text: json["message"].stringValue)
            
        default:
            return .error
        }
    }
}
