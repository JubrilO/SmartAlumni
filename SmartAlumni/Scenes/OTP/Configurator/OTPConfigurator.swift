//
//  OTPConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 8/13/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

final class OTPConfigurator {


    // MARK: - Singleton

    static let sharedInstance: OTPConfigurator = OTPConfigurator()


    // MARK: - Configuration

    func configure(viewController: OTPViewController) {

        let router = OTPRouter(viewController: viewController)
        let presenter = OTPPresenter(output: viewController)
        let interactor = OTPInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
