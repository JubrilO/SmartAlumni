//
//  MessagesConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 12/11/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

final class MessagesConfigurator {


    // MARK: - Singleton

    static let sharedInstance: MessagesConfigurator = MessagesConfigurator()


    // MARK: - Configuration

    func configure(viewController: MessagesListViewController) {

        let router = MessagesRouter(viewController: viewController)
        let presenter = MessagesPresenter(output: viewController)
        let interactor = MessagesInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
