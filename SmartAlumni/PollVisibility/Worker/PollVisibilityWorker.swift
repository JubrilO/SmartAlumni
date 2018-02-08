//
//  PollVisibilityWorker.swift
//  SmartAlumni
//
//  Created by Jubril on 11/23/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

class PollVisibilityWorker {


    // MARK: - Business Logic
    
    func fetchSchools(completionHandler: @escaping ([School]?, Error?) -> ()) {
        
        SchoolAPI.sharedManager.getAllSchools() {
            schools, error in
            completionHandler(schools, error)
        }
    }
    
}
