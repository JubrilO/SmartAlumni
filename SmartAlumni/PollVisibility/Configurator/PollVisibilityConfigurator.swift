//
//  PollVisibilityConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 11/23/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

final class PollVisibilityConfigurator {


    // MARK: - Singleton

    static let sharedInstance: PollVisibilityConfigurator = PollVisibilityConfigurator()


    // MARK: - Configuration

    func configure(viewController: PollVisibilityViewController) {

        let router = PollVisibilityRouter(viewController: viewController)
        let presenter = PollVisibilityPresenter(output: viewController)
        let interactor = PollVisibilityInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
