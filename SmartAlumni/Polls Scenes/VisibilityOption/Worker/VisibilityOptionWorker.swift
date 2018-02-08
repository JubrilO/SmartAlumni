//
//  VisibilityOptionWorker.swift
//  SmartAlumni
//
//  Created by Jubril on 11/28/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

class VisibilityOptionWorker {


    // MARK: - Business Logic

    func fetchSchools(completionHandler: @escaping ([School]?, Error?) -> ()) {
        
        SchoolAPI.sharedManager.getAllSchools() {
            schools, error in
            completionHandler(schools, error)
        }
    }}
