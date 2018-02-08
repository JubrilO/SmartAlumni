//
//  PollCompletionRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 11/28/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol PollCompletionRouterProtocol {

    weak var viewController: PollCompletionViewController? { get }

    func navigateToSomewhere()
}

final class PollCompletionRouter {

    weak var viewController: PollCompletionViewController?


    // MARK: - Initializers

    init(viewController: PollCompletionViewController?) {

        self.viewController = viewController
    }
}


// MARK: - PollCompletionRouterProtocol

extension PollCompletionRouter: PollCompletionRouterProtocol {


    // MARK: - Navigation

    func navigateToSomewhere() {

    }
}
