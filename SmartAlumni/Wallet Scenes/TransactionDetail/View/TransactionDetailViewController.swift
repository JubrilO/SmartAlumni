//
//  TransactionDetailViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 2/9/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

protocol TransactionDetailViewControllerInput: TransactionDetailPresenterOutput {
    
}

protocol TransactionDetailViewControllerOutput {
    
    func doSomething()
}

final class TransactionDetailViewController: UIViewController {
    
    var output: TransactionDetailViewControllerOutput!
    var router: TransactionDetailRouterProtocol!
    
    @IBOutlet weak var transactionDescriptionTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var transactionIDTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var amountTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var transactionTypeTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var transactionTypeLabel: UILabel!
    
    var textFields = [SkyFloatingLabelTextField]()
    // MARK: - Initializers
    
    init(configurator: TransactionDetailConfigurator = TransactionDetailConfigurator.sharedInstance) {
        
        super.init(nibName: nil, bundle: nil)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configure()
    }
    
    
    // MARK: - Configurator
    
    private func configure(configurator: TransactionDetailConfigurator = TransactionDetailConfigurator.sharedInstance) {
        
        configurator.configure(viewController: self)
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextfieldFonts()
    }
    
    
    // MARK: - Load data
    
    func setupTextfieldFonts() {
        textFields = [amountTextField, transactionIDTextField, transactionTypeTextField, transactionDescriptionTextField]
        let titleFont = UIFont.boldSystemFont(ofSize: 10)
        for field in textFields {
            field.titleFont = titleFont
        }
    }
}


// MARK: - TransactionDetailPresenterOutput

extension TransactionDetailViewController: TransactionDetailViewControllerInput {
    
    
    // MARK: - Display logic
    
    func displaySomething(viewModel: TransactionDetailViewModel) {
        
        // TODO: Update UI
    }
}
