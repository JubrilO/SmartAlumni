//
//  WelcomeViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 8/23/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol WelcomeViewControllerInput: WelcomePresenterOutput {

}

protocol WelcomeViewControllerOutput {

    func getFirstName()
}

final class WelcomeViewController: UIViewController {

    var output: WelcomeViewControllerOutput!
    var router: WelcomeRouterProtocol!

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var joinSchoolButton: UIButton!

    // MARK: - Initializers

    init(configurator: WelcomeConfigurator = WelcomeConfigurator.sharedInstance) {

        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        configure()
    }


    // MARK: - Configurator

    private func configure(configurator: WelcomeConfigurator = WelcomeConfigurator.sharedInstance) {

        configurator.configure(viewController: self)
    }


    // MARK: - View lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()

        getFirstName()
    }

    @IBAction func onJoinSchoolButtonTouch(_ sender: UIButton) {
        
        router.navigateToJoinSchoolList()
    }

    // MARK: - Load data

    func getFirstName() {

        // TODO: Ask the Interactor to do some work

        output.getFirstName()
    }
}


// MARK: - WelcomePresenterOutput

extension WelcomeViewController: WelcomeViewControllerInput {


    // MARK: - Display logic

    func displayFirstName(viewModel: WelcomeViewModel) {

        welcomeLabel.text = "Welcome \(viewModel.firstName.capitalized)!"
    }
}
