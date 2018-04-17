//
//  BanksListViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 4/9/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import UIKit

class BanksListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var doneButton = UIBarButtonItem()
    var banks = [Bank]()
    var selectedBank: Bank?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Bank"
        navigationItem.backBarButtonItem?.tintColor = Constants.Colors.softBlue
        addDoneButton()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllBanks()
    }
    
    func addDoneButton() {
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTap))
        doneButton.title = "Done"
        doneButton.tintColor = Constants.Colors.softBlue
        if selectedBank == nil {
            doneButton.isEnabled = false
        }
        navigationItem.setRightBarButton(doneButton, animated: false)
    }
    
    @objc func onDoneButtonTap() {
        if let prevVC =  previousViewController as? AddBankViewController {
            prevVC.selectedBank = selectedBank
        }
        navigationController?.popViewController(animated: true)
    }
    
    func fetchAllBanks() {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tintColor = Constants.Colors.softBlue
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.layoutIfNeeded()
        activityIndicator.startAnimating()
        ProjectAPI.sharedManager.getAllBanks {
            banks, error in
            activityIndicator.stopAnimating()
            guard let banks = banks else {
                self.displayErrorModal(error: error?.localizedDescription)
                return
            }
            self.banks = banks
            self.tableView.reloadData()
        }
    }
}

extension BanksListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bank = banks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.BankCell) as! BankCell
        cell.accessoryType = .none
        cell.bankNameLabel.text = bank.name
        if let selectedBank = selectedBank {
            if bank.id == selectedBank.id {
                cell.setSelected(true, animated: true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBank = banks[indexPath.row]
        doneButton.isEnabled = true
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
