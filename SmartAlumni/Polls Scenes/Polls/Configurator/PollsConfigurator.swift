//
//  PollsConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 10/27/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

final class PollsConfigurator {


    // MARK: - Singleton

    static let sharedInstance: PollsConfigurator = PollsConfigurator()


    // MARK: - Configuration

    func configure(viewController: PollsViewController) {

        let router = PollsRouter(viewController: viewController)
        let presenter = PollsPresenter(output: viewController)
        let interactor = PollsInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
