//
//  SelectSetWorker.swift
//  SmartAlumni
//
//  Created by Jubril on 8/29/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

class SelectSetWorker {


    // MARK: - Business Logic

    func joinSchool(schoolID: String, facultyID: String? = nil, departmentID: String? = nil, set: Int, completionHandler: @escaping (Bool, String?) -> ()) {
       print("Preparing to make API Call")
        UserAPI.sharedManager.joinSchool(schoolID: schoolID, facultyID: facultyID, departmentID: departmentID, set: set) {
            success, error in
            completionHandler(success, error)
        
        }
    }
}
