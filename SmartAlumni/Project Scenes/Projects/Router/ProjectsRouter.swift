//
//  ProjectsRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 3/5/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ProjectsRouterProtocol {
    
    weak var viewController: ProjectsViewController? { get }
    
    func navigateToProjectDetails(project: Project)
    func navigateToNewProjectScene()
}

final class ProjectsRouter {
    
    weak var viewController: ProjectsViewController?
    
    
    // MARK: - Initializers
    
    init(viewController: ProjectsViewController?) {
        
        self.viewController = viewController
    }
}


// MARK: - ProjectsRouterProtocol

extension ProjectsRouter: ProjectsRouterProtocol {
    
    
    // MARK: - Navigation
    
    func navigateToProjectDetails(project: Project) {
        let projectStoryboard = UIStoryboard(name: Constants.StoryboardNames.Project, bundle: nil)
        if let projectDetailViewController = projectStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.ProjectDetailScene) as? ProjectDetailViewController {
            projectDetailViewController.output.project = project
            projectDetailViewController.hidesBottomBarWhenPushed = true
            viewController?.navigationController?.pushViewController(projectDetailViewController, animated: true)
        }
    }
    
    func navigateToNewProjectScene() {
        let projectStoryboard = UIStoryboard(name: Constants.StoryboardNames.Project, bundle: nil)
        if let newProjectViewController = projectStoryboard.instantiateViewController(withIdentifier: "NewProjectNavScene") as? UINavigationController {
            viewController?.present(newProjectViewController, animated: true, completion: nil)
        }
    }
}
