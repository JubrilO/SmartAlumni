//
//  FundProjectCompleteViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 4/4/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import UIKit

class FundProjectCompleteViewController: UIViewController {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var schoolLable: UILabel!
    
    var amountDonated = 0
    var projectName = ""
    var schoolName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        hideNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    func setupLabels() {
    amountLabel.text = "You donated NGN \(amountDonated) to \(projectName)"
    schoolLable.text = "We'll send a notification to \(schoolName). You can view details in your transaction history"
    }
    
    @IBAction func onDoneButtonClick(sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}
