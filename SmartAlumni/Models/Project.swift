//
//  Project.swift
//  SmartAlumni
//
//  Created by Jubril on 3/14/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import SwiftyJSON

class Project {
    var id = ""
    var title = ""
    var amount: Double = 0
    var status = ""
    var description = ""
    var schoolName = ""
    var set = ""
    var paystackSubaccount = ""
    var raisedAmount: Double = 0
    var donors = [Donor]()
    var imageURL = ""
    var startDate: Date?
    var endDate: Date?
    
    required convenience init(json: JSON) {
        self.init()
        self.id = json["_id"].stringValue
        self.title = json["name"].stringValue
        self.amount = json["amount"].doubleValue
        self.description = json["description"].stringValue
        self.status = json["status"].stringValue
        self.imageURL = json["image"].stringValue
        self.paystackSubaccount = json["paystack_subaccount"].stringValue
        self.schoolName = json["visibility"]["school"]["name"].stringValue
        self.raisedAmount = json["raised_amount"].doubleValue
        let startDateString = json["start_date"].stringValue
        let endDateString = json["end_date"].stringValue
        self.startDate = convertStringToDate(dateString: startDateString)
        self.endDate = convertStringToDate(dateString: endDateString)
        var donors = [Donor]()
        for donorJson in json["donors"].arrayValue {
            let donor = Donor(json: donorJson)
            donors.append(donor)
        }
        self.donors = donors
        
    }
    
    private func convertStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter.date(from: dateString)
    }
    
    func numberOfDaysLeft() -> Int? {
        guard let start = startDate, let end = endDate else {return nil}
        let calendar = Calendar.current
        let unitFlag = Set<Calendar.Component>([ .day])
        let dateComponents = calendar.dateComponents(unitFlag, from: start, to: end)
        return dateComponents.day
    }
    
    func percentageCompletion() -> Int {
        if amount <= 0 {
            return 0
        }
        return Int(round(raisedAmount/amount * 100))
    }
}
