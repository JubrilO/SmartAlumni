//
//  Poll.swift
//  SmartAlumni
//
//  Created by Jubril on 9/25/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON

class Poll {
    var id = ""
    var name = ""
    var question = ""
    var startDate = Date()
    var endDate = Date()
    var status = PollStatus.ongoing
    var options = [PollOption]()
    
    enum PollStatus {
        case ongoing
        case completed
    }
    
    required convenience init(json: JSON) {
        self.init()
        self.id = json["_id"].stringValue
        self.name = json["name"].stringValue
        self.question = json["question"].stringValue
        let optionsArray = json["options"].arrayValue
        var options = [PollOption]()
        for optionJSON in optionsArray {
            let pollOption = PollOption(json: optionJSON)
            options.append(pollOption)
        }
        self.options = options
        if json["status"].stringValue == "ongoing" {
            self.status = PollStatus.ongoing
        }
        else {
            self.status = PollStatus.completed
        }
        let startDateString = json["start_date"].stringValue
        let endDateString = json["end_date"].stringValue
        if let startDate = convertStringToDate(dateString: startDateString), let endDate = convertStringToDate(dateString: endDateString) {
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    private func convertStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
}
