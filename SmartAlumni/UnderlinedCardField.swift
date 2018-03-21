//
//  UnderlinedCardField.swift
//  SmartAlumni
//
//  Created by Jubril on 3/18/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import Paystack

class UnderlinedCardField: PSTCKPaymentCardTextField {
    override func draw(_ rect: CGRect) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = Constants.Colors.medGrey.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        self.setNeedsDisplay()
        //self.tintColor = borderColor
    }
}
