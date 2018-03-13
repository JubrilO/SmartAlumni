//
//  SchoolDetails.swift
//  SmartAlumni
//
//  Created by Jubril on 3/2/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import RealmSwift

class SchoolDetails: Object {
    @objc dynamic var schoolID = ""
    @objc dynamic var facultyID = ""
    @objc dynamic var departmentID = ""
    @objc dynamic var set = 0
    
    required convenience init(schoolID: String, facultyID: String = "", departmentID: String = "", set: Int = 0) {
        self.init()
        self.schoolID = schoolID
        self.departmentID = departmentID
        self.facultyID = facultyID
        self.set = set
    }
    
    func toJSON() -> [String : Any] {
        let json : [String : Any] =
            [
                "school" : schoolID,
                "faculty" : facultyID,
                "department" : departmentID,
                "school_set" : set
            ]

        return json
    }
}
