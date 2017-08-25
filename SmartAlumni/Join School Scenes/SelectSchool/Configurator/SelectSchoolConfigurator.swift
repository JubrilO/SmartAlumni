//
//  SelectSchoolConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 8/24/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

final class SelectSchoolConfigurator {


    // MARK: - Singleton

    static let sharedInstance: SelectSchoolConfigurator = SelectSchoolConfigurator()


    // MARK: - Configuration

    func configure(viewController: SelectSchoolViewController) {

        let router = SelectSchoolRouter(viewController: viewController)
        let presenter = SelectSchoolPresenter(output: viewController)
        let interactor = SelectSchoolInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
