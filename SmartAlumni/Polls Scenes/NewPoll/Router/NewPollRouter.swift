//
//  NewPollRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 11/2/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol NewPollRouterProtocol {

    weak var viewController: NewPollViewController? { get }

    func navigateToSomewhere()
}

final class NewPollRouter {

    weak var viewController: NewPollViewController?


    // MARK: - Initializers

    init(viewController: NewPollViewController?) {

        self.viewController = viewController
    }
}


// MARK: - NewPollRouterProtocol

extension NewPollRouter: NewPollRouterProtocol {


    // MARK: - Navigation

    func navigateToSomewhere() {

    }
}
