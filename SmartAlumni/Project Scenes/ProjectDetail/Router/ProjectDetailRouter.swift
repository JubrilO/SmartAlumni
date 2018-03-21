//
//  ProjectDetailRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 3/15/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ProjectDetailRouterProtocol {

    weak var viewController: ProjectDetailViewController? { get }

    func navigateToFundProject(project: Project)
}

final class ProjectDetailRouter {

    weak var viewController: ProjectDetailViewController?


    // MARK: - Initializers

    init(viewController: ProjectDetailViewController?) {

        self.viewController = viewController
    }
}


// MARK: - ProjectDetailRouterProtocol

extension ProjectDetailRouter: ProjectDetailRouterProtocol {


    // MARK: - Navigation

    func navigateToFundProject(project: Project) {
        let fundProjectVC = viewController?.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.FundProjectScene)
        fundProjectVC?.hidesBottomBarWhenPushed = true
        UIApplication.shared.keyWindow?.addSubview(viewController!.view)
        
 viewController?.navigationController?.pushViewController(fundProjectVC!, animated: true)
        viewController!.view.removeFromSuperview()
        }
}
