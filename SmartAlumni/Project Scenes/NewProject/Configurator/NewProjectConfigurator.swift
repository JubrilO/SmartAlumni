//
//  NewProjectConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 2/20/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

final class NewProjectConfigurator {


    // MARK: - Singleton

    static let sharedInstance: NewProjectConfigurator = NewProjectConfigurator()


    // MARK: - Configuration

    func configure(viewController: NewProjectViewController) {

        let router = NewProjectRouter(viewController: viewController)
        let presenter = NewProjectPresenter(output: viewController)
        let interactor = NewProjectInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
