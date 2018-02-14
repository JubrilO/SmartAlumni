//
//  WalletLandingViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 2/9/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol WalletLandingViewControllerInput: WalletLandingPresenterOutput {

}

protocol WalletLandingViewControllerOutput {

    func doSomething()
}

final class WalletLandingViewController: UIViewController {

    var output: WalletLandingViewControllerOutput!
    var router: WalletLandingRouterProtocol!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var accountBalanceLabel: UILabel!
    
    // MARK: - Initializers

    init(configurator: WalletLandingConfigurator = WalletLandingConfigurator.sharedInstance) {

        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        configure()
    }


    // MARK: - Configurator

    private func configure(configurator: WalletLandingConfigurator = WalletLandingConfigurator.sharedInstance) {

        configurator.configure(viewController: self)
    }


    // MARK: - View lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    @IBAction func onViewAllButtonTap(_ sender: UIButton) {
        
    }
    
    @IBAction func onTransferButtonTap(_ sender: UIButton) {
    }
    // MARK: - Load data

}


// MARK: - WalletLandingPresenterOutput

extension WalletLandingViewController: WalletLandingViewControllerInput {


    // MARK: - Display logic

    func displaySomething(viewModel: WalletLandingViewModel) {

        // TODO: Update UI
    }
}

extension WalletLandingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.TransactionCell) as! TransactionCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.navigateToTransactionDetail()
    }
}
