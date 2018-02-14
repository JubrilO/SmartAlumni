//
//  TransactionDetailRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 2/9/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol TransactionDetailRouterProtocol {

    weak var viewController: TransactionDetailViewController? { get }

    func navigateSomewhere()
}

final class TransactionDetailRouter {

    weak var viewController: TransactionDetailViewController?


    // MARK: - Initializers

    init(viewController: TransactionDetailViewController?) {

        self.viewController = viewController
    }
}


// MARK: - TransactionDetailRouterProtocol

extension TransactionDetailRouter: TransactionDetailRouterProtocol {


    // MARK: - Navigation
    
    func navigateSomewhere() {
        
    }
    
}
