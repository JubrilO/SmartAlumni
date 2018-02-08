//
//  APIConstants.swift
//  SmartAlumni
//
//  Created by Jubril on 8/7/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation

struct APIConstants {
    
    static let RootURL = "https://www.smartalumni.ng/api"
    static let UserURL = RootURL + "/user"
    static let OtpURL = UserURL + "/otp"
    static let SignUpURL = UserURL + "/sign-up"
    static let UpdateProfileURL = UserURL + "/update"
    static let SchoolURL = RootURL + "/school"
    static let JoinSchoolURL = UserURL + "/join-school"
    static let PollURL = RootURL + "/poll"
    static let VotePollURL = PollURL + "/vote"
    static let AllPollsURL = PollURL + "/all"
    static let CreatePollURL = PollURL + "/create"

}
