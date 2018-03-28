//
//  EditProfileCell.swift
//  SmartAlumni
//
//  Created by Jubril on 3/28/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import UIKit

class EditProfileSettingCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
