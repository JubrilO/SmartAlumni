//
//  NewProjectViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 2/20/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol NewProjectViewControllerInput: NewProjectPresenterOutput {

}

protocol NewProjectViewControllerOutput {

    func doSomething()
}

final class NewProjectViewController: UIViewController {

    var output: NewProjectViewControllerOutput!
    var router: NewProjectRouterProtocol!


    // MARK: - Initializers

    init(configurator: NewProjectConfigurator = NewProjectConfigurator.sharedInstance) {

        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        configure()
    }


    // MARK: - Configurator

    private func configure(configurator: NewProjectConfigurator = NewProjectConfigurator.sharedInstance) {

        configurator.configure(viewController: self)
    }


    // MARK: - View lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()

        doSomethingOnLoad()
    }


    // MARK: - Load data

    func doSomethingOnLoad() {

        // TODO: Ask the Interactor to do some work

        output.doSomething()
    }
}


// MARK: - NewProjectPresenterOutput

extension NewProjectViewController: NewProjectViewControllerInput {


    // MARK: - Display logic

    func displaySomething(viewModel: NewProjectViewModel) {

        // TODO: Update UI
    }
}
