//
//  SelectSchoolWorker.swift
//  SmartAlumni
//
//  Created by Jubril on 8/24/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

class SelectSchoolWorker {


    // MARK: - Business Logic

    func fetchAllSchools(completionHandler: @escaping ([School]?, String?) -> ()) {
        
        SchoolAPI.sharedManager.getAllSchools {
            schools, error in
            completionHandler(schools, error)
        }
    }
}
