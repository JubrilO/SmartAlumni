//
//  WelcomeWorker.swift
//  SmartAlumni
//
//  Created by Jubril on 8/23/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import RealmSwift

class WelcomeWorker {


    // MARK: - Business Logic

    func getFirstName() -> String? {

        let realm = try! Realm()
        if let user =  realm.objects(User.self).first {
            return user.firstName
        }
        else {
            return nil
        }
    }
    
}
