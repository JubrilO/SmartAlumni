//
//  BankCell.swift
//  SmartAlumni
//
//  Created by Jubril on 4/9/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import UIKit

class BankCell: UITableViewCell {
    @IBOutlet weak var bankNameLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.accessoryType = .checkmark
        }
    }
}
