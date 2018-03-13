//
//  ProjectsConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 3/5/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

final class ProjectsConfigurator {


    // MARK: - Singleton

    static let sharedInstance: ProjectsConfigurator = ProjectsConfigurator()


    // MARK: - Configuration

    func configure(viewController: ProjectsViewController) {

        let router = ProjectsRouter(viewController: viewController)
        let presenter = ProjectsPresenter(output: viewController)
        let interactor = ProjectsInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
