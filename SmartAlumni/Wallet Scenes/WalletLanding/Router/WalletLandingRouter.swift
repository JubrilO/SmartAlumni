//
//  WalletLandingRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 2/9/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol WalletLandingRouterProtocol {

    weak var viewController: WalletLandingViewController? { get }

    func navigateToTransactionDetail()
}

final class WalletLandingRouter {

    weak var viewController: WalletLandingViewController?


    // MARK: - Initializers

    init(viewController: WalletLandingViewController?) {

        self.viewController = viewController
    }
}


// MARK: - WalletLandingRouterProtocol

extension WalletLandingRouter: WalletLandingRouterProtocol {


    // MARK: - Navigation

    func navigateToTransactionDetail() {
        let walletStoryboard = UIStoryboard(name: Constants.StoryboardNames.Wallet, bundle: nil)
        let transactionVC = walletStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.TransactionDetailScene)
        viewController?.navigationController?.pushViewController(transactionVC, animated: true)
    }
}
