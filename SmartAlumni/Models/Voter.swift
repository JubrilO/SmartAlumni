//
//  Voter.swift
//  SmartAlumni
//
//  Created by Jubril on 3/7/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON

class Voter {
    var userID = ""
    var selectedOption = 0
    
    required convenience init(json: JSON) {
        self.init()
        self.userID = json["user"].stringValue
        self.selectedOption = json["option"].intValue
    }
}
