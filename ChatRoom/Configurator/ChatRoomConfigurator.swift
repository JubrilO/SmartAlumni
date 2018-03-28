//
//  ChatRoomConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 3/22/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

final class ChatRoomConfigurator {


    // MARK: - Singleton

    static let sharedInstance: ChatRoomConfigurator = ChatRoomConfigurator()


    // MARK: - Configuration

    func configure(viewController: ChatRoomViewController) {

        let router = ChatRoomRouter(viewController: viewController)
        let presenter = ChatRoomPresenter(output: viewController)
        let interactor = ChatRoomInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
