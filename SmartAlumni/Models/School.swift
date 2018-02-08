//
//  School.swift
//  SmartAlumni
//
//  Created by Jubril on 8/25/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class School {
    
    var id = ""
    var name = ""
    var category = ""
    var imageURL: String?
    var sets = [String]()
    var departments = [Department]()
    var faculties = [Faculty]()
    
    required convenience init(json: JSON) {
        self.init()
        self.id = json["_id"].stringValue
        self.name = json["name"].stringValue
        self.category = json["category"].stringValue
        self.imageURL = json["image"].string
        if let sets = json["sets"].arrayObject as? [String] {
            self.sets = sets
        }
                
        var departments = [Department]()
        for departmentJson in json["departments"].arrayValue {
            let deparment = Department(json: departmentJson)
            departments.append(deparment)
        }
        self.departments = departments
        
        var faculties = [Faculty]()
        for facultyJson in json["faculties"].arrayValue {
            let faculty = Faculty(json: facultyJson)
            faculties.append(faculty)
        }
        self.faculties = faculties
    }
    
    
}
