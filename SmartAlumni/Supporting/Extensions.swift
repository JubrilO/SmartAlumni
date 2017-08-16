//
//  Extensions.swift
//  SmartAlumni
//
//  Created by Jubril on 8/8/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayErrorModal(error: String) {
        
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
