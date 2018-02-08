//
//  PollVisibilityRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 11/23/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol PollVisibilityRouterProtocol {

    weak var viewController: PollVisibilityViewController? { get }

    func navigateToVisibilityOptionScene(dataType: DataType)
}

final class PollVisibilityRouter {

    weak var viewController: PollVisibilityViewController?


    // MARK: - Initializers

    init(viewController: PollVisibilityViewController?) {

        self.viewController = viewController
    }
}


// MARK: - PollVisibilityRouterProtocol

extension PollVisibilityRouter: PollVisibilityRouterProtocol {
    
    func navigateToVisibilityOptionScene(dataType: DataType) {
        
    }
    
    func navigateToVisibilityOptionScene() {
        
    }
    
}
