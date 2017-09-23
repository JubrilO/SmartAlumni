//
//  JoinSetCompletionViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 9/23/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import UIKit

class JoinSetCompletionViewController: UIViewController {

    @IBOutlet weak var successLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissScreen(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
