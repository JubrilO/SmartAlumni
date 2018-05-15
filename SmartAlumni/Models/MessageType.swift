//
//  Contact.swift
//  SmartAlumni
//
//  Created by Jubril on 5/7/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import RealmSwift

class Contact: Object {
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var phone = ""
    
    required convenience init(name: String, email: String, phone: String) {
        self.init()
        self.name = name
        self.email = email
        self.phone = phone
    }
}

class Document: Object {
    @objc dynamic var name = ""
    @objc dynamic var size = ""
    @objc dynamic var url = ""
    
    required convenience init(name: String, size: String, url: String) {
        self.init()
        self.name = name
        self.url = url
        self.size = size
    }
}

class AdminText: Object {
    @objc dynamic var text = ""
    required convenience init(_ text: String) {
        self.init()
        self.text = text
    }
}

class Image: Object {
    @objc dynamic var urlString = ""
    required convenience init(urlString: String) {
        self.init()
        self.urlString = urlString
    }
}
