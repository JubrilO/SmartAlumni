//
//  PollCompletionConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 11/28/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

final class PollCompletionConfigurator {


    // MARK: - Singleton

    static let sharedInstance: PollCompletionConfigurator = PollCompletionConfigurator()


    // MARK: - Configuration

    func configure(viewController: PollCompletionViewController) {

        let router = PollCompletionRouter(viewController: viewController)
        let presenter = PollCompletionPresenter(output: viewController)
        let interactor = PollCompletionInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
