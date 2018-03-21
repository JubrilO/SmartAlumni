//
//  FundProjectConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 3/16/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

final class FundProjectConfigurator {


    // MARK: - Singleton

    static let sharedInstance: FundProjectConfigurator = FundProjectConfigurator()


    // MARK: - Configuration

    func configure(viewController: FundProjectViewController) {

        let router = FundProjectRouter(viewController: viewController)
        let presenter = FundProjectPresenter(output: viewController)
        let interactor = FundProjectInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
