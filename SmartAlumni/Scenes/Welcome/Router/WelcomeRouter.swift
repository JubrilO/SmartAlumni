//
//  WelcomeRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 8/23/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol WelcomeRouterProtocol {

    weak var viewController: WelcomeViewController? { get }

    func navigateToJoinSchoolList()
}

final class WelcomeRouter {

    weak var viewController: WelcomeViewController?


    // MARK: - Initializers

    init(viewController: WelcomeViewController?) {

        self.viewController = viewController
    }
}


// MARK: - WelcomeRouterProtocol

extension WelcomeRouter: WelcomeRouterProtocol {


    // MARK: - Navigation

    func navigateToJoinSchoolList() {
        
        
    }
}
