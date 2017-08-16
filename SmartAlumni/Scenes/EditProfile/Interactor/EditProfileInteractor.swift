//
//  EditProfileInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 8/15/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol EditProfileInteractorInput: EditProfileViewControllerOutput {

}

protocol EditProfileInteractorOutput {

    func presentSomething()
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


    // MARK: - Business logic

    func doSomething() {

        // TODO: Create some Worker to do the work

        worker.doSomeWork()

        // TODO: Pass the result to the Presenter

        output.presentSomething()
    }
    
    func saveProfile(firstName: String, lastName: String, email: String, profileImage: UIImage) {
        worker.updateProfile()
    }
}
