//
//  AmountTextField.swift
//  SmartAlumni
//
//  Created by Jubril on 3/19/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField

class AmountTextField: SkyFloatingLabelTextField {
    override func lineViewRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        let height = editing ? selectedLineHeight : lineHeight
        return CGRect(x: 0, y: bounds.size.height + 5 - height, width: bounds.size.width, height: height)
    }
}
