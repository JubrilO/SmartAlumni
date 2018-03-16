//
//  ProjectDetailConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 3/15/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

final class ProjectDetailConfigurator {


    // MARK: - Singleton

    static let sharedInstance: ProjectDetailConfigurator = ProjectDetailConfigurator()


    // MARK: - Configuration

    func configure(viewController: ProjectDetailViewController) {

        let router = ProjectDetailRouter(viewController: viewController)
        let presenter = ProjectDetailPresenter(output: viewController)
        let interactor = ProjectDetailInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
