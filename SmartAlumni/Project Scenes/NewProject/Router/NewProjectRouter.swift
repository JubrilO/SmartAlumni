//
//  NewProjectRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 2/20/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol NewProjectRouterProtocol {

    weak var viewController: NewProjectViewController? { get }

    func navigateToSomewhere()
}

final class NewProjectRouter {

    weak var viewController: NewProjectViewController?


    // MARK: - Initializers

    init(viewController: NewProjectViewController?) {

        self.viewController = viewController
    }
}


// MARK: - NewProjectRouterProtocol

extension NewProjectRouter: NewProjectRouterProtocol {


    // MARK: - Navigation

    func navigateToSomewhere() {

    }
}
