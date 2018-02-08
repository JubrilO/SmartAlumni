//
//  MessagesViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 12/11/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol MessagesViewControllerInput: MessagesPresenterOutput {

}

protocol MessagesViewControllerOutput {

    func doSomething()
}

final class MessagesViewController: UIViewController {

    var output: MessagesViewControllerOutput!
    var router: MessagesRouterProtocol!


    // MARK: - Initializers

    init(configurator: MessagesConfigurator = MessagesConfigurator.sharedInstance) {

        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        configure()
    }


    // MARK: - Configurator

    private func configure(configurator: MessagesConfigurator = MessagesConfigurator.sharedInstance) {

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


// MARK: - MessagesPresenterOutput

extension MessagesViewController: MessagesViewControllerInput {


    // MARK: - Display logic

    func displaySomething(viewModel: MessagesViewModel) {

        // TODO: Update UI
    }
}
