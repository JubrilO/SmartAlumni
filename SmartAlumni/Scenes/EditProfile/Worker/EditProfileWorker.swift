//
//  EditProfileWorker.swift
//  SmartAlumni
//
//  Created by Jubril on 8/15/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

class EditProfileWorker {
    
    
    // MARK: - Business Logic
    
    func updateProfile(firstName: String, lastName: String, username: String, email: String, profileImage: UIImage, completionHandler: @escaping (User?, String?) -> ()) {
        
        guard let uid = UserDefaults.standard.string(forKey: Constants.UserDefaults.UID) else {
            
            completionHandler(nil, "Could not get UID")
            return
        }
        let updateParameters = [
            "first_name" : firstName,
            "last_name" : lastName,
            "email" : email,
            "name" : username
        ]
        let parameters: [String : Any] = [
            "_id" : uid,
            "update" : updateParameters
        ]
        
        UserAPI.sharedManager.updateProfile(parameters: parameters) {
            user, error in
            completionHandler(user, error)
        }
    }
}
