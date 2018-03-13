//
//  ProjectsRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 3/5/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ProjectsRouterProtocol {

    weak var viewController: ProjectsViewController? { get }

    func navigateToSomewhere()
}

final class ProjectsRouter {

    weak var viewController: ProjectsViewController?


    // MARK: - Initializers

    init(viewController: ProjectsViewController?) {

        self.viewController = viewController
    }
}


// MARK: - ProjectsRouterProtocol

extension ProjectsRouter: ProjectsRouterProtocol {


    // MARK: - Navigation

    func navigateToSomewhere() {

    }
}
