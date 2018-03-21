//
//  CardTextField.swift
//  SmartAlumni
//
//  Created by Jubril on 3/19/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import Paystack

class CardTextField: PSTCKPaymentCardTextField {
    override func brandImageRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 2, y: 2, width: 26, height: bounds.size.height - 2)
    }
}
