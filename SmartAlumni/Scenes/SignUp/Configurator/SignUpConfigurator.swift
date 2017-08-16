//
//  SignUpConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 8/7/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

final class SignUpConfigurator {


    // MARK: - Singleton

    static let sharedInstance: SignUpConfigurator = SignUpConfigurator()


    // MARK: - Configuration

    func configure(viewController: SignUpViewController) {

        let router = SignUpRouter(viewController: viewController)
        let presenter = SignUpPresenter(output: viewController)
        let interactor = SignUpInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
