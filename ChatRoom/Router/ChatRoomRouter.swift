//
//  ChatRoomRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 3/22/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ChatRoomRouterProtocol {

    weak var viewController: ChatRoomViewController? { get }

    func navigateToSomewhere()
}

final class ChatRoomRouter {

    weak var viewController: ChatRoomViewController?


    // MARK: - Initializers

    init(viewController: ChatRoomViewController?) {

        self.viewController = viewController
    }
}


// MARK: - ChatRoomRouterProtocol

extension ChatRoomRouter: ChatRoomRouterProtocol {


    // MARK: - Navigation

    func navigateToSomewhere() {

    }
}
