//
//  OptionView.swift
//  SmartAlumni
//
//  Created by Jubril on 11/16/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import UIKit

class OptionView: UIView {
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var overlayView: UIView
    @IBOutlet weak var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var pollCompletionIndicator: UIImageView!
    
    func fillUpBar(percentage: Double) {
        UIView.animate(withDuration: 0.3, animations: {
            self.overlayView.frame = CGRect(x: 0, y: 0, (width: percentage/100 * self.frame.width), height: self.frame.height)
        })
    }
    
    func updateProgressLabel(percentage: Int) {
        self.progressLabel.text = "\(percentage)%"
    }
    
    func hideCompletionIndicator() {
        pollCompletionIndicator.isHidden = true
    }
}
