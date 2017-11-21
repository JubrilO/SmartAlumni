//
//  PollCell.swift
//  SmartAlumni
//
//  Created by Jubril on 11/18/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import UIKit

class PollCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var optionStackView: UIStackView!
    
    func setup(poll: Poll) {
        self.titleLabel.text = poll.name
        self.questionLabel.text = poll.question
    }
}
