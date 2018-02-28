//
//  ConversationRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 2/15/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ConversationRouterProtocol {

    weak var viewController: ConversationViewController? { get }

    func navigateToSomewhere()
}

final class ConversationRouter {

    weak var viewController: ConversationViewController?


    // MARK: - Initializers

    init(viewController: ConversationViewController?) {

        self.viewController = viewController
    }
}


// MARK: - ConversationRouterProtocol

extension ConversationRouter: ConversationRouterProtocol {


    // MARK: - Navigation

    func navigateToSomewhere() {

    }
}
