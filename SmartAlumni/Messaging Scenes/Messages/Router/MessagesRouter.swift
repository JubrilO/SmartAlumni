//
//  MessagesRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 12/11/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol MessagesRouterProtocol {

    weak var viewController: MessagesViewController? { get }

    func navigateToSomewhere()
}

final class MessagesRouter {

    weak var viewController: MessagesViewController?


    // MARK: - Initializers

    init(viewController: MessagesViewController?) {

        self.viewController = viewController
    }
}


// MARK: - MessagesRouterProtocol

extension MessagesRouter: MessagesRouterProtocol {


    // MARK: - Navigation

    func navigateToSomewhere() {

    }
}
