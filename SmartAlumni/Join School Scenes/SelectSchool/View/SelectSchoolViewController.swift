//
//  SelectSchoolViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 8/24/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol SelectSchoolViewControllerInput: SelectSchoolPresenterOutput {

}

protocol SelectSchoolViewControllerOutput {

    func fetchAllSchools()
}

final class SelectSchoolViewController: UIViewController {

    var output: SelectSchoolViewControllerOutput!
    var router: SelectSchoolRouterProtocol!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Initializers

    init(configurator: SelectSchoolConfigurator = SelectSchoolConfigurator.sharedInstance) {

        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        configure()
    }


    // MARK: - Configurator

    private func configure(configurator: SelectSchoolConfigurator = SelectSchoolConfigurator.sharedInstance) {

        configurator.configure(viewController: self)
    }


    // MARK: - View lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()

        fetchAllSchools()
    }


    // MARK: - Load data

    func fetchAllSchools() {

        // TODO: Ask the Interactor to do some work
        tableView.isHidden = true
        activityIndicator.startAnimating()
        output.fetchAllSchools()
    }
}


// MARK: - SelectSchoolPresenterOutput

extension SelectSchoolViewController: SelectSchoolViewControllerInput {


    // MARK: - Display logic

    func displaySomething(viewModel: SelectSchoolViewModel) {

        // TODO: Update UI
    }
}
