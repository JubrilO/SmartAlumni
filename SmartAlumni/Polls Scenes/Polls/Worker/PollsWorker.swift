//
//  PollsWorker.swift
//  SmartAlumni
//
//  Created by Jubril on 10/27/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

class PollsWorker {


    // MARK: - Business Logic

    func fetchPolls(completionHandler: @escaping ([Poll]?, String?) -> ()) {
        
        PollAPI.sharedManager.getAllPolls {
            polls, error in
                completionHandler(polls, error)
        }
    }
}
