//
//  ProjectDetailInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 3/15/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ProjectDetailInteractorInput: ProjectDetailViewControllerOutput {

}

protocol ProjectDetailInteractorOutput {

    func presentProject(project: Project)
}

final class ProjectDetailInteractor: ProjectDetailViewControllerOutput {

    let output: ProjectDetailInteractorOutput
    let worker: ProjectDetailWorker

    var project = Project()
    // MARK: - Initializers

    init(output: ProjectDetailInteractorOutput, worker: ProjectDetailWorker = ProjectDetailWorker()) {

        self.output = output
        self.worker = worker
    }


    // MARK: - Business logic
    
    func fetchProject() {
        output.presentProject(project: project)
    }

}
