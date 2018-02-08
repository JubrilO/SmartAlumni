//
//  PollCompletionViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 11/28/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol PollCompletionViewControllerInput: PollCompletionPresenterOutput {

}

protocol PollCompletionViewControllerOutput {

    func doSomething()
}

final class PollCompletionViewController: UIViewController {

    var output: PollCompletionViewControllerOutput!
    var router: PollCompletionRouterProtocol!


    // MARK: - Initializers

    init(configurator: PollCompletionConfigurator = PollCompletionConfigurator.sharedInstance) {

        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        configure()
    }


    // MARK: - Configurator

    private func configure(configurator: PollCompletionConfigurator = PollCompletionConfigurator.sharedInstance) {

        configurator.configure(viewController: self)
    }


    // MARK: - View lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()
    }
    
    @IBAction func onDoneButtonClick(_ sender: UIButton) {
    }
    

}


// MARK: - PollCompletionPresenterOutput

extension PollCompletionViewController: PollCompletionViewControllerInput {


    // MARK: - Display logic

    func displaySomething(viewModel: PollCompletionViewModel) {

        // TODO: Update UI
    }
}
