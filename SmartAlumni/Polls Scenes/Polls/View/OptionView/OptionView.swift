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
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var pollCompletionIndicator: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var overlayWidthConstraint: NSLayoutConstraint!
    
    var option = PollOption()
    
    override func draw(_ rect: CGRect) {
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.cornerRadius = 2
        backgroundView.clipsToBounds = true
        backgroundView.layer.borderColor = Constants.Colors.softBlue.cgColor
    }
    
    class func instanceFromNib() -> OptionView {
        return UINib(nibName: "OptionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! OptionView
    }
    
    
    func fillUpBar(percentage: Double, animated: Bool) {
        if animated {
            self.overlayWidthConstraint.constant = CGFloat(percentage/100) * self.bounds.width
            UIView.animate(withDuration: 0.4){
                self.layoutIfNeeded()
            }
        }
        else {
            self.overlayWidthConstraint.constant = CGFloat(percentage/100) * self.frame.width
        }
    }
    
    func updateProgressLabel(percentage: Int) {
        self.progressLabel.text = "\(percentage)%"
    }
    
    func hideCompletionIndicator() {
        pollCompletionIndicator.isHidden = true
    }
}
