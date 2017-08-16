//
//  WelcomeViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 8/6/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onAgreeButtonTouch(_ sender: UIButton) {
        
        if let verifyNumberVC = storyboard?.instantiateViewController(withIdentifier: "verifyNumberVC") {
            navigationController?.pushViewController(verifyNumberVC, animated: true)
        }
    }
    
}
