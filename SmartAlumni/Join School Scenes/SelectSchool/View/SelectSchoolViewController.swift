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
    
    var schools: [School] {get}
    var searchResults: [School] {get}
    var schoolCategory: SchoolCategory {get set}
    func fetchSchools()
    func updateSearchResults(searchText: String)
    func routeToSchool(index: Int)
}

final class SelectSchoolViewController: UIViewController {

    var output: SelectSchoolViewControllerOutput!
    var router: SelectSchoolRouterProtocol!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var schoolViewModels = [SelectSchoolViewModel]()
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
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        setupTableView()
        setupNavigationBar()
        fetchSchools()
    }


    // MARK: - Load data

    func fetchSchools() {

        tableView.isHidden = true
        activityIndicator.startAnimating()
        output.fetchSchools()
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
    }
    
    func setupNavigationBar() {
        title = "Select a School"
        let leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: #selector(popViewController))
        navigationItem.backBarButtonItem = leftBarButtonItem
        navigationItem.backBarButtonItem?.tintColor = Constants.Colors.softBlue
    }
    
    @objc func popViewController() {
       navigationController?.popViewController(animated: true)
    }
}


// MARK: - SelectSchoolPresenterOutput

extension SelectSchoolViewController: SelectSchoolViewControllerInput {

    // MARK: - Display logic
    
    func displayError(errorMessage: String) {
        activityIndicator.stopAnimating()
        displayErrorModal(error: errorMessage)
    }
    
    func displaySchools(viewModels: [SelectSchoolViewModel]) {
        tableView.isHidden = false
        activityIndicator.stopAnimating()
        schoolViewModels = viewModels
        tableView.reloadData()
    }
}

//MARK: -TableViewDataSource


extension SelectSchoolViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = schoolViewModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.SelectSchoolCell) as! SelectSchoolCell
        cell.schoolLabel.text = viewModel.schoolName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolViewModels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.navigateToSelectSetScene(schoolIndex: indexPath.row)
    }
}

//MARK: - UISearchBarDelegate

extension SelectSchoolViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output.updateSearchResults(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        output.updateSearchResults(searchText: "")
    }
}
