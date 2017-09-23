//
//  SelectSetConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 8/29/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

final class SelectSetConfigurator {


    // MARK: - Singleton

    static let sharedInstance: SelectSetConfigurator = SelectSetConfigurator()


    // MARK: - Configuration

    func configure(viewController: SelectSetViewController) {

        let router = SelectSetRouter(viewController: viewController)
        let presenter = SelectSetPresenter(output: viewController)
        let interactor = SelectSetInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
