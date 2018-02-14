//
//  ChatRoomViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 2/14/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ChatRoomViewControllerInput: ChatRoomPresenterOutput {

}

protocol ChatRoomViewControllerOutput {

    func doSomething()
}

final class ChatRoomViewController: UIViewController {

    var output: ChatRoomViewControllerOutput!
    var router: ChatRoomRouterProtocol!


    // MARK: - Initializers

    init(configurator: ChatRoomConfigurator = ChatRoomConfigurator.sharedInstance) {

        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        configure()
    }


    // MARK: - Configurator

    private func configure(configurator: ChatRoomConfigurator = ChatRoomConfigurator.sharedInstance) {

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


// MARK: - ChatRoomPresenterOutput

extension ChatRoomViewController: ChatRoomViewControllerInput {


    // MARK: - Display logic

    func displaySomething(viewModel: ChatRoomViewModel) {

        // TODO: Update UI
    }
}
