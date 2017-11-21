//
//  TimeIntervalPicker.swift
//  SmartAlumni
//
//  Created by Jubril on 11/2/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import UIKit

class TimeIntervalPicker: UIPickerView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



extension UIPickerView {
    
    func setPickerLabels(labels: [Int:UILabel], containedView: UIView) { // [component number:label]
        
        let fontSize:CGFloat = 13
        let labelWidth:CGFloat = containedView.bounds.width / CGFloat(self.numberOfComponents)
        let y:CGFloat = (self.frame.size.height / 2) - (fontSize / 2)
        
        for i in 0...self.numberOfComponents {
            
            if let label = labels[i] {
                
                if self.subviews.contains(label) {
                    label.removeFromSuperview()
                }
                
                label.frame = CGRect(x: 18 + (labelWidth/2) + (labelWidth * CGFloat(i)), y: y, width: label.bounds.width, height: label.bounds.height)
                label.font = UIFont.boldSystemFont(ofSize: fontSize)
                label.backgroundColor = .clear
                label.textAlignment = NSTextAlignment.center
                
                self.addSubview(label)
            }
        }
    }
}
