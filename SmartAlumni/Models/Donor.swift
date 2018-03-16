//
//  Donor.swift
//  SmartAlumni
//
//  Created by Jubril on 3/15/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON

class Donor {
   
    var uid = ""
    var amountDonated: Double = 0
    var datePaid: Date?
    
    required convenience init(json: JSON) {
        self.init()
        self.uid = json["user"].stringValue
        self.amountDonated = json["amount"].doubleValue
    }
}
