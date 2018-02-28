//
//  VisibilityOptionViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 11/28/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol VisibilityOptionViewControllerInput: VisibilityOptionPresenterOutput {
    
}

protocol VisibilityOptionViewControllerOutput {
    var schoolData: [String] {get set}
    var dataType: DataType {get set}
    var schools: [School] {get set}
    var faculties: [Faculty] {get set}
    var sets: [String] {get set}
    var departments: [Department] {get set}
    func fetchData()
}

final class VisibilityOptionViewController: UIViewController {
    
    var output: VisibilityOptionViewControllerOutput!
    var router: VisibilityOptionRouterProtocol!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var doneButton = UIBarButtonItem()
    
    
    
    // MARK: - Initializers
    
    init(configurator: VisibilityOptionConfigurator = VisibilityOptionConfigurator.sharedInstance) {
        
        super.init(nibName: nil, bundle: nil)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configure()
    }
    
    
    // MARK: - Configurator
    
    private func configure(configurator: VisibilityOptionConfigurator = VisibilityOptionConfigurator.sharedInstance) {
        
        configurator.configure(viewController: self)
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        initialSetup()
        addDoneButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.fetchData()
        if output.dataType == .School{
            activityIndicator.startAnimating()
        }
    }
    
    func addDoneButton() {
        doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDoneButtonClick))
        navigationItem.rightBarButtonItem = doneButton
        doneButton.tintColor = .black
        doneButton.isEnabled = false
    }
    
    @objc func onDoneButtonClick(sender: UIBarButtonItem) {
        print("Done button clicked")
        if let selectedIndexes = tableView.indexPathsForSelectedRows {
            print("Selected indexes exist")
            router.routeToNewPollScene(selectedIndexes: selectedIndexes, dataType: output.dataType)
        }
    }
    
    func initialSetup() {
        activityIndicator.hidesWhenStopped = true
        tableView.tableFooterView = UIView()
        switch output.dataType {
        case .School:
            title = "Target School"
            tableView.allowsMultipleSelection = false
        case .Faculty:
            title = "Target Faculty"
            tableView.allowsMultipleSelection = true
        case .Department:
            title = "Target Department"
            tableView.allowsMultipleSelection = true
        case .Set:
            title = "Target Set"
            tableView.allowsMultipleSelection = true
        }
    }
}


// MARK: - VisibilityOptionPresenterOutput

extension VisibilityOptionViewController: VisibilityOptionViewControllerInput {
    
    
    // MARK: - Display logic
    
    func displayData() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }
}

extension VisibilityOptionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.VisibilityOptionCell) as! VisibilityOptionCell
        cell.checkmarkImageView.image = Constants.PlaceholderImages.Circle
        cell.titleLabel.text = output.schoolData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch output.dataType {
        case .Department:
            return output.departments.count
        case .Faculty:
            return output.faculties.count
        case .School:
            return output.schools.count
        case .Set:
            return output.sets.count
        }
    }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath) as! VisibilityOptionCell
            cell.checkmarkImageView.image = Constants.PlaceholderImages.Checkmark
            doneButton.isEnabled = true
        }
        
        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath) as! VisibilityOptionCell
            cell.checkmarkImageView.image = Constants.PlaceholderImages.Circle
//            if let selectedRows = tableView.indexPathsForSelectedRows {
//                if selectedRows.isEmpty { doneButton.isEnabled = false }
//            }
        }
    }


enum DataType: String{
    case School
    case Faculty
    case Department
    case Set
}
