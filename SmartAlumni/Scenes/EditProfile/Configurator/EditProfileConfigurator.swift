//
//  EditProfileConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 8/15/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

final class EditProfileConfigurator {


    // MARK: - Singleton

    static let sharedInstance: EditProfileConfigurator = EditProfileConfigurator()


    // MARK: - Configuration

    func configure(viewController: EditProfileViewController) {

        let router = EditProfileRouter(viewController: viewController)
        let presenter = EditProfilePresenter(output: viewController)
        let interactor = EditProfileInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
