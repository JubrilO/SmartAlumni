//
//  Poll.swift
//  SmartAlumni
//
//  Created by Jubril on 9/25/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Poll: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var question = ""
    @objc dynamic var startDate = Date()
    @objc dynamic var endDate = Date()
    let voters = List<Voter>()
    @objc private dynamic var pollStat = PollStatus.ongoing.rawValue
    var status: PollStatus {
        get{return PollStatus(rawValue: pollStat)!}
        set{pollStat = newValue.rawValue}
    }
    let options = List<PollOption>()
    
    enum PollStatus: String {
        case ongoing
        case completed
    }
    
    required convenience init(json: JSON) {
        self.init()
        self.id = json["_id"].stringValue
        self.name = json["name"].stringValue
        self.question = json["question"].stringValue
        let optionsArray = json["options"].arrayValue
        for optionJSON in optionsArray {
            let pollOption = PollOption(json: optionJSON)
            self.options.append(pollOption)
        }
        let votersArray = json["voters"].arrayValue
        for voterJson in  votersArray {
            let voter = Voter(json: voterJson)
            self.voters.append(voter)
        }
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
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private func convertStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter.date(from: dateString)
    }
}
