//
//  WelcomeConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 8/23/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

final class WelcomeConfigurator {


    // MARK: - Singleton

    static let sharedInstance: WelcomeConfigurator = WelcomeConfigurator()


    // MARK: - Configuration

    func configure(viewController: WelcomeViewController) {

        let router = WelcomeRouter(viewController: viewController)
        let presenter = WelcomePresenter(output: viewController)
        let interactor = WelcomeInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
