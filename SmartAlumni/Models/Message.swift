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
import RealmSwift

class Message: Object, MessageType {
    
    
    enum MessageType {
        case text(text: String)
        case image(imageurl: String)
        case document(name: String, size: String, url: String)
        case contact(name: String, email: String, phone: String)
        case admin(text: String)
        case error
    }
    
    @objc dynamic var messageId = ""
    @objc dynamic var user = ""
    @objc dynamic var content = ""
    @objc dynamic var chatroomID = ""
    @objc dynamic var  messageContent:  MessageContent?
    @objc dynamic var sentDate = Date()
    @objc dynamic var senderUID = ""
    @objc dynamic var senderDisplayName = ""
    var data: MessageData {
        set {
            switch newValue {
            case .text(let text):
                messageContent?.text = text
                case .photo(<#T##UIImage#>)
            default:
                <#code#>
            }
            
        }
        get {
            switch messageContent?.messageType {
            case MessageTypeConstants.text:
                return MessageData.text(messageContent!.text)
            case MessageTypeConstants.image:
                return MessageData.photo(UIImage(named: messageContent!.image!.urlString)!)
            default:
                return MessageData.text("")
            }
        }
    }
    
    var sender: Sender {
        return Sender(id: senderUID, displayName: senderDisplayName)
    }
    
    
    required convenience init(json: JSON) {
        self.init()
        self.user = json["user"].stringValue
        self.chatroomID = json["room"].stringValue
        self.messageId = json["messageid"].stringValue
        let text = json["message"].stringValue
        if json["user"].exists() {
            let user = User(jsonData: json["user"])
            self.senderUID = user.uid
            self.senderDisplayName = user.username
        }
        self.content = text
        let epochDouble = json["timestamp"].doubleValue
        self.sentDate = parseDateFrom(epoch: epochDouble)
        self.messageContent = populateMessageContentFrom(json: json)
    }
    
    convenience init(sender: User, text: String, type: String, messageID: String, chatRoomID: String) {
        self.init()
        self.user = sender.uid
        self.content = text
        let messageContent = MessageContent()
        messageContent.messageType = type
        self.chatroomID = chatRoomID
        self.senderUID  = sender.uid
        self.senderDisplayName = sender.username
        switch type {
        case MessageTypeConstants.text:
            messageContent.text = text
        default:
            break
        }
        self.messageContent = messageContent
        self.messageId = messageID
        self.sentDate = Date()
    }
    
    convenience init(sender: User, image: UIImage, type: String, messageID: String, chatRoomID: String) {
        self.init()
        self.user = sender.uid
        self.content = ""
        let messageContent = MessageContent()
        messageContent.messageType = type
        self.chatroomID = chatRoomID
        switch type {
        case MessageTypeConstants.text:
            messageContent.text = ""
        case MessageTypeConstants.image:
            messageContent.image!.urlString = ""
        default:
            break
        }
        self.senderUID  = sender.uid
        self.senderDisplayName = sender.username
        self.messageId = messageID
        self.sentDate = Date()
    }
    
    func populateMessageContentFrom(json: JSON) -> MessageContent {
        let messageContent = MessageContent()
        let typeString = json["type"].stringValue
        messageContent.messageType = typeString
        
        switch typeString {
            
        case MessageTypeConstants.text:
            messageContent.text = json["message"].stringValue
            
        case MessageTypeConstants.contact:
            let name = json["contact"]["name"].stringValue
            let email = json["contact"]["email"].stringValue
            let phone = json["contact"]["phone"].stringValue
            let contact =  Contact(name: name, email: email, phone: phone)
            messageContent.contact = contact
            
        case MessageTypeConstants.document:
            let fileName = json["document"]["name"].stringValue
            let fileSize = json["document"]["size"].stringValue
            let fileURL = json["document"]["remote_url"].stringValue
            let document =  Document(name: fileName, size: fileSize, url: fileURL)
            messageContent.document = document
            
        case MessageTypeConstants.image:
            let imageURL = json["image"]["remote_url"].stringValue
            let image = Image(urlString: imageURL)
            messageContent.image = image
            
        case MessageTypeConstants.admin:
            let adminText = AdminText(json["message"].stringValue)
            messageContent.adminText = adminText
            
        default:
            break
        }
        return messageContent
    }
    
    func toJsonDict() -> [String : Any] {
        var jsonDict = [String : Any]()
        
        switch self.messageContent!.messageType {
        case MessageTypeConstants.text:
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
            
        case MessageTypeConstants.image:
            jsonDict = ["message" : [
                "timestamp" : Int(self.sentDate.timeIntervalSince1970),
                "message" : self.content,
                "messageid" : self.messageId,
                "type" : MessageTypeConstants.image,
                "user" : self.user,
                "room" : self.chatroomID,
                "image" : ["remote_url" : self.messageContent!.image!.urlString]
                ]
            ]
            return jsonDict
            
        case MessageTypeConstants.contact:
            jsonDict = ["message" : [
                "timestamp" : Int(self.sentDate.timeIntervalSince1970),
                "message" : self.content,
                "messageid" : self.messageId,
                "type" : MessageTypeConstants.contact,
                "user" : self.user,
                "room" : self.chatroomID,
                "contact" : [
                    "email" : messageContent!.contact!.email,
                    "name" : messageContent!.contact!.name,
                    "phone" : messageContent!.contact!.phone]
                ]
            ]
            return jsonDict
            
        case MessageTypeConstants.document:
            jsonDict = ["message" : [
                "timestamp" : Int(self.sentDate.timeIntervalSince1970),
                "message" : self.content,
                "messageid" : self.messageId,
                "type" : MessageTypeConstants.document,
                "user" : self.user,
                "room" : self.chatroomID,
                "document" : [
                    "name" : messageContent!.document!.name,
                    "size" : messageContent!.document!.size,
                    "remote_url" : messageContent!.document!.url ]
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
    
}

struct MessageTypeConstants {
    static let text = "TYPE_TEXT"
    static let image = "TYPE_IMAGE"
    static let document = "TYPE_DOCUMENT"
    static let contact = "TYPE_CONTACT"
    static let admin = "TYPE_ADMIN"
    static let error = "TYPE_ERROR"
}

