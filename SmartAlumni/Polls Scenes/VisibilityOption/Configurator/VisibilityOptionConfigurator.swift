//
//  VisibilityOptionConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 11/28/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

final class VisibilityOptionConfigurator {


    // MARK: - Singleton

    static let sharedInstance: VisibilityOptionConfigurator = VisibilityOptionConfigurator()


    // MARK: - Configuration

    func configure(viewController: VisibilityOptionViewController) {

        let router = VisibilityOptionRouter(viewController: viewController)
        let presenter = VisibilityOptionPresenter(output: viewController)
        let interactor = VisibilityOptionInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
