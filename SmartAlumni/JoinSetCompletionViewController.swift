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
    var school: School?
    var set: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        successLabel.text = "You have successfully joined \(school!.name) \(set!) set"
    }
    
    @IBAction func dismissScreen(_ sender: UIButton) {
        let landingStoryboard = UIStoryboard(name: "Landing", bundle: nil)
        let landingVC = landingStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.LandingTabBarScene)
        present(landingVC, animated: true, completion: nil)
    }
    
    
}
