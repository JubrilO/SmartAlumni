//
//  PollsRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 10/27/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol PollsRouterProtocol {

    weak var viewController: PollsViewController? { get }

    func navigateToSomewhere()
    func navigateToNewPollScene()
}

final class PollsRouter {

    weak var viewController: PollsViewController?


    // MARK: - Initializers

    init(viewController: PollsViewController?) {

        self.viewController = viewController
    }
}


// MARK: - PollsRouterProtocol

extension PollsRouter: PollsRouterProtocol {


    // MARK: - Navigation
    
    func navigateToNewPollScene() {
        let pollStoryboard = UIStoryboard(name: Constants.StoryboardNames.Polls, bundle: nil)
        if let pollsNavVC = pollStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.PollsNavScene) as? UINavigationController {
            viewController?.present(pollsNavVC, animated: true, completion: nil)
        }
        
    }

    func navigateToSomewhere() {

    }
}
