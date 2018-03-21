//
//  FundProjectRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 3/16/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol FundProjectRouterProtocol {

    weak var viewController: FundProjectViewController? { get }

    func navigateToSomewhere()
}

final class FundProjectRouter {

    weak var viewController: FundProjectViewController?


    // MARK: - Initializers

    init(viewController: FundProjectViewController?) {

        self.viewController = viewController
    }
}


// MARK: - FundProjectRouterProtocol

extension FundProjectRouter: FundProjectRouterProtocol {


    // MARK: - Navigation

    func navigateToSomewhere() {

    }
}
