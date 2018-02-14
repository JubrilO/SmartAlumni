//
//  WalletLandingConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 2/9/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

final class WalletLandingConfigurator {


    // MARK: - Singleton

    static let sharedInstance: WalletLandingConfigurator = WalletLandingConfigurator()


    // MARK: - Configuration

    func configure(viewController: WalletLandingViewController) {

        let router = WalletLandingRouter(viewController: viewController)
        let presenter = WalletLandingPresenter(output: viewController)
        let interactor = WalletLandingInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
