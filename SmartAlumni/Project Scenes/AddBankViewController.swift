//
//  AddBankViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 4/6/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftValidator

class AddBankViewController: UIViewController, ValidationDelegate {
    
    @IBOutlet weak var accountNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var bankNameLabel: UILabel!
    var selectedBank: Bank?
    
    let validator = Validator()
    override func viewDidLoad() {
        super.viewDidLoad()
        initalSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        setupTextFieldFonts()
        if let selectedBank = selectedBank {
            self.bankNameLabel.text = selectedBank.name
        }
    }

    @IBAction func onBankCellTap(_ sender: UITapGestureRecognizer) {
        pushBanksListScene()
    }
    
    func initalSetup() {
        validator.registerField(accountNumberTextField, rules: [RequiredRule()])
    }
    
    func setupTextFieldFonts() {
        let titleFont = UIFont.boldSystemFont(ofSize: 10)
        accountNumberTextField.titleFont = titleFont
    }
    
    func setupNavBar(){
        navigationItem.backBarButtonItem?.tintColor = Constants.Colors.softBlue
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTap))
        doneButton.tintColor = Constants.Colors.softBlue
        doneButton.title = "Done"
        navigationItem.setRightBarButton(doneButton, animated: false)
    }
    
    func pushBanksListScene() {
        let banksVC = storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.BanksListScene) as! BanksListViewController
        banksVC.selectedBank = selectedBank
        navigationController?.pushViewController(banksVC, animated: true)
    }
    
    @objc func onDoneButtonTap() {
        validator.validate(self)
    }
    
    func validationSuccessful() {
        guard let bank = selectedBank else {
            displayErrorModal(error: "Please select a bank")
            return
        }
        
        if let previousVC = navigationController?.previousViewController as? NewProjectViewController {
            let accountDetails = AccountDetails(accountNumber: accountNumberTextField.text!, bank: bank)
            previousVC.output.accountDetails = accountDetails
            navigationController?.popViewController(animated: true)
        }
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (field, error ) in errors {
            if let field = field as? SkyFloatingLabelTextField {
                field.errorMessage = error.errorMessage
            }
        }
    }
    
}

struct AccountDetails {
    var accountNumber = ""
    var bank: Bank
}
