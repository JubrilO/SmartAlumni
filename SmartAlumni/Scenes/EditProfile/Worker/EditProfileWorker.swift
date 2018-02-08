//
//  EditProfileWorker.swift
//  SmartAlumni
//
//  Created by Jubril on 8/15/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import RealmSwift
import PromiseKit


class EditProfileWorker {
    
    
    // MARK: - Business Logic
    
    func updateProfileParams(firstName: String, lastName: String, username: String, phoneNumber: String, profileImage: UIImage) -> Promise<User> {
        return Promise { fulfil, reject in
            firstly {
                uploadImageToServer(image: profileImage)
            }.then { image in
                self.updateProfile(firstName: firstName, lastName: lastName, username: username, phoneNumber: phoneNumber, profileImageURL: image)
            }.then { user in
                fulfil(user)
            }.catch { error in
                reject(error)
            }
        }
    }
    
    
    private func updateProfile(firstName: String, lastName: String, username: String, phoneNumber: String, profileImageURL: String) -> Promise<User> {
        return Promise { fulfil, reject in
            guard let uid = UserDefaults.standard.string(forKey: Constants.UserDefaults.UID) else {
                reject(PMKError.invalidCallingConvention)
                return
            }
            
            let updateParameters = [
                "first_name" : firstName,
                "last_name" : lastName,
                "phone_number" : phoneNumber,
                "name": username,
                "profile_image" : profileImageURL
            ]
            let parameters: [String : Any] = [
                "_id" : uid,
                "update" : updateParameters
            ]
            
            UserAPI.sharedManager.updateProfile(parameters: parameters) {
                user, error in
                if let user = user {
                    fulfil(user)
                }
                else if let error = error {
                    reject(error)
                } else {
                    reject(PMKError.invalidCallingConvention)
                }
            }
            
        }
    }
    
    private func uploadImageToServer(image: UIImage) -> Promise<String> {
        return Promise { fulfil, reject in
            UserAPI.sharedManager.saveImageToFirebase(image: image, quality: .medium) {
                urlString, error in
                if let urlString = urlString {
                    fulfil(urlString)
                } else if let error = error {
                    reject(error)
                } else {
                    reject(PMKError.invalidCallingConvention)
                }
            }
        }
    }
    
    func addUserToRealm(user: User)  {
        let realm = try! Realm()
        try! Realm().write {
            realm.add(user)
        }
    }
}
