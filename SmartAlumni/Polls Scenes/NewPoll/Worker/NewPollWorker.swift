//
//  NewPollWorker.swift
//  SmartAlumni
//
//  Created by Jubril on 11/2/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

class NewPollWorker {


    // MARK: - Business Logic
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()


    func createNewPoll(title: String, question: String, options: [Option], startDate: Date, duration: Int, visiblity: [String: Any], completionHandler: @escaping (Bool?, String?) -> ()) {
        let startDateFormatted = dateFormatter.string(from: startDate)
        //let endDateFormatted = dateFormatter.string(from: endDate)
        PollAPI.sharedManager.createPoll(title: title, question: question, options: options, startDate: startDateFormatted, duration: duration, visibility: visiblity) {
            success, error in
            completionHandler(success, error)
        }
    }
}
