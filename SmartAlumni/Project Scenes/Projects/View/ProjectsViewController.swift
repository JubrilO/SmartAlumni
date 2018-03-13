//
//  ProjectsViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 3/5/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ProjectsViewControllerInput: ProjectsPresenterOutput {

}

protocol ProjectsViewControllerOutput {

    func doSomething()
}

final class ProjectsViewController: UIViewController {

    var output: ProjectsViewControllerOutput!
    var router: ProjectsRouterProtocol!


    // MARK: - Initializers

    init(configurator: ProjectsConfigurator = ProjectsConfigurator.sharedInstance) {

        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        configure()
    }


    // MARK: - Configurator

    private func configure(configurator: ProjectsConfigurator = ProjectsConfigurator.sharedInstance) {

        configurator.configure(viewController: self)
    }


    // MARK: - View lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()

        doSomethingOnLoad()
    }


    // MARK: - Load data

    func doSomethingOnLoad() {

        // TODO: Ask the Interactor to do some work

        output.doSomething()
    }
}


// MARK: - ProjectsPresenterOutput

extension ProjectsViewController: ProjectsViewControllerInput {


    // MARK: - Display logic

    func displaySomething(viewModel: ProjectsViewModel) {

        // TODO: Update UI
    }
}
