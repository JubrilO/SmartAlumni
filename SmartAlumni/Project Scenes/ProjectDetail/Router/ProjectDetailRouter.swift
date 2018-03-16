//
//  ProjectDetailRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 3/15/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ProjectDetailRouterProtocol {

    weak var viewController: ProjectDetailViewController? { get }

    func navigateToSomewhere()
}

final class ProjectDetailRouter {

    weak var viewController: ProjectDetailViewController?


    // MARK: - Initializers

    init(viewController: ProjectDetailViewController?) {

        self.viewController = viewController
    }
}


// MARK: - ProjectDetailRouterProtocol

extension ProjectDetailRouter: ProjectDetailRouterProtocol {


    // MARK: - Navigation

    func navigateToSomewhere() {

    }
}
