//
//  EditProfileInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 8/15/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import RealmSwift
import PromiseKit


protocol EditProfileInteractorInput: EditProfileViewControllerOutput {
    
}

protocol EditProfileInteractorOutput {
    
    func presentError(errorMessage: String)
    func presentNextScene()
    func presentUsersEmail(email: String)
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
    
    
    func fetchEmailAddress() {
        if let email = UserDefaults.standard.string(forKey: Constants.UserDefaults.Email) {
            output.presentUsersEmail(email: email)
        }
    }
    
    func saveProfile(firstName: String, lastName: String, username: String, phoneNumber: String, profileImage: UIImage) {
        firstly {
            self.worker.updateProfileParams(firstName: firstName, lastName: lastName, username: username, phoneNumber: phoneNumber, profileImage: profileImage)
        }.then { user -> Void in
            self.worker.addUserToRealm(user: user)
            self.output.presentNextScene()
        }.catch { error in
             self.output.presentError(errorMessage: error.localizedDescription)
        }
    }
}
