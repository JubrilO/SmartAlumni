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

    @IBOutlet weak var tableView: UITableView!
    let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDoneButtonClick))

    
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
        output.fetchData()
    }
    
    func addDoneButton() {
        doneButton.tintColor = .black
        doneButton.isEnabled = false
    }
    
    func onDoneButtonClick() {
        if let selectedIndexes = tableView.indexPathsForSelectedRows {
            router.routeToNewPollScene(selectedIndexes: selectedIndexes, dataType: output.dataType)
        }
    }
    
    func initialSetup() {
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
        return output.schoolData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch output.dataType {
        case .School:
            router.routeToNewPollScene(selectedRowIndex: indexPath.row, dataType: .School)
        default:
            let cell = tableView.cellForRow(at: indexPath) as! VisibilityOptionCell
            cell.checkmarkImageView.image = Constants.PlaceholderImages.Checkmark
            doneButton.isEnabled = true
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
                let cell = tableView.cellForRow(at: indexPath) as! VisibilityOptionCell
        cell.checkmarkImageView.image = Constants.PlaceholderImages.Circle
        if let selectedRows = tableView.indexPathsForSelectedRows {
            if selectedRows.isEmpty { doneButton.isEnabled = false }
        }
    }
}

enum DataType: String{
    case School
    case Faculty
    case Department
    case Set
}
