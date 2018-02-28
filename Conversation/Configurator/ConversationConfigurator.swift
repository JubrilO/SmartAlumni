//
//  ConversationConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 2/15/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

final class ConversationConfigurator {


    // MARK: - Singleton

    static let sharedInstance: ConversationConfigurator = ConversationConfigurator()


    // MARK: - Configuration

    func configure(viewController: ConversationViewController) {

        let router = ConversationRouter(viewController: viewController)
        let presenter = ConversationPresenter(output: viewController)
        let interactor = ConversationInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
