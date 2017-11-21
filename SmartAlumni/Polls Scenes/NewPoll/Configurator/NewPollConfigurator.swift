//
//  NewPollConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 11/2/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

final class NewPollConfigurator {


    // MARK: - Singleton

    static let sharedInstance: NewPollConfigurator = NewPollConfigurator()


    // MARK: - Configuration

    func configure(viewController: NewPollViewController) {

        let router = NewPollRouter(viewController: viewController)
        let presenter = NewPollPresenter(output: viewController)
        let interactor = NewPollInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
