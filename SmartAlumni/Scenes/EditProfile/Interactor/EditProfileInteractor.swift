//
//  EditProfileInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 8/15/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import RealmSwift

protocol EditProfileInteractorInput: EditProfileViewControllerOutput {
    
}

protocol EditProfileInteractorOutput {
    
    func presentError(errorMessage: String)
    func presentNextScene()
}

final class EditProfileInteractor {
    
    let output: EditProfileInteractorOutput
    let worker: EditProfileWorker
    
    
    // MARK: - Initializers
    
    init(output: EditProfileInteractorOutput, worker: EditProfileWorker = EditProfileWorker()) {
        
        self.output = output
        self.worker = worker
    }
}


// MARK: - EditProfileInteractorInput

extension EditProfileInteractor: EditProfileViewControllerOutput {
    
    func saveProfile(firstName: String, lastName: String, username: String, email: String, profileImage: UIImage) {
        
        worker.updateProfile(firstName: firstName, lastName: lastName, username: username, email: email, profileImage: profileImage) {
            user, error in
            
            guard error == nil else {
                self.output.presentError(errorMessage: error!)
                return
            }
            if let user = user {
                self.worker.addUserToRealm(user: user)
                self.output.presentNextScene()
            }
        }
    }
}
