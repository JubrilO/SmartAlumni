//
//  TransactionDetailConfigurator.swift
//  SmartAlumni
//
//  Created by Jubril on 2/9/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

final class TransactionDetailConfigurator {


    // MARK: - Singleton

    static let sharedInstance: TransactionDetailConfigurator = TransactionDetailConfigurator()


    // MARK: - Configuration

    func configure(viewController: TransactionDetailViewController) {

        let router = TransactionDetailRouter(viewController: viewController)
        let presenter = TransactionDetailPresenter(output: viewController)
        let interactor = TransactionDetailInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
