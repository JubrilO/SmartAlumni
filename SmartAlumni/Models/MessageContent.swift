//
//  MessageData.swift
//  SmartAlumni
//
//  Created by Jubril on 5/7/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import RealmSwift

class MessageContent : Object {
    @objc dynamic var text  = ""
    @objc dynamic var messageType = ""
    @objc dynamic var document:  Document?
    @objc dynamic var contact: Contact?
    @objc dynamic var adminText: AdminText?
    @objc dynamic var image: Image?
    
}
