//
//  VisibilityOptionCell.swift
//  SmartAlumni
//
//  Created by Jubril on 11/28/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import UIKit

class VisibilityOptionCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.accessoryType = .checkmark
        }
    }
}
