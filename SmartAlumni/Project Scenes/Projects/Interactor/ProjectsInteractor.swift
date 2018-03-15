//
//  ProjectsInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 3/5/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ProjectsInteractorInput: ProjectsViewControllerOutput {

}

protocol ProjectsInteractorOutput {

    func presentProjects()
}

final class ProjectsInteractor: ProjectsViewControllerOutput {

    let output: ProjectsInteractorOutput
    let worker: ProjectsWorker
    var projects = [Project]()

    // MARK: - Initializers

    init(output: ProjectsInteractorOutput, worker: ProjectsWorker = ProjectsWorker()) {

        self.output = output
        self.worker = worker
    }

    


    // MARK: - ProjectsInteractorInput
    
    


    // MARK: - Business logic

    func fetchProjects() {
        ProjectAPI.sharedManager.getAllProjects {
            projects, error in
            guard let projects = projects else {
                print(error?.localizedDescription ?? "")
                return
            }
            self.projects = projects
            self.output.presentProjects()
        }
    }
}
