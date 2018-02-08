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

    func createNewPoll(title: String, question: String, options: [Option], startDate: String, endDate: String, visiblity: [String: Any], completionHandler: @escaping (Bool?, String?) -> ()) {
        PollAPI.sharedManager.createPoll(title: title, question: question, options: options, startDate: startDate, endDate: startDate, visibility: visiblity) {
            success, error in
            
        }
    }
}
