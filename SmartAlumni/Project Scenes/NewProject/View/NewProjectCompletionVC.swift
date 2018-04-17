//
//  NewProjectCompletionVC.swift
//  SmartAlumni
//
//  Created by Jubril on 4/16/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import UIKit

class NewProjectCompletionVC: UIViewController {

    @IBAction func onDoneButtonTap(_ sender: UIButton) {
       navigationController?.dismiss(animated: true, completion: nil)
    }
}
