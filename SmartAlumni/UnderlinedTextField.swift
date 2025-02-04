//
//  UnderlinedTextField.swift
//  SmartAlumni
//
//  Created by Jubril on 7/31/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import UIKit

class UnderlinedTextField: UITextField {
    
    var borderColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0) {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);

    
    override func draw(_ rect: CGRect) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = borderColor.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        self.tintColor = borderColor
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds: bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds: bounds)
    }
    
    private func newBounds(bounds: CGRect) -> CGRect {
        var newBounds = bounds
        newBounds.origin.x += padding.left
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right
        return newBounds
    }

}
