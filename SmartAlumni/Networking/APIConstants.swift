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
    static let UserSchoolURL = UserURL + "/schools"
    static let ChatRoomURL = RootURL + "/room"
    static let OtpURL = UserURL + "/otp"
    static let SignUpURL = UserURL + "/sign-up"
    static let UpdateProfileURL = UserURL + "/update"
    static let SchoolURL = RootURL + "/school"
    static let JoinSchoolURL = UserURL + "/join-school"
    static let PollURL = RootURL + "/poll"
    static let VotePollURL = PollURL + "/vote"
    static let AllPollsURL = PollURL + "/all"
    static let UsersPollURL = PollURL + "/user"
    static let CreatePollURL = PollURL + "/create-ios"
    static let UserChatRoomsURL = ChatRoomURL + "/user"
    static let GetMessagesURL = ChatRoomURL + "/get-chat-history"
    static let CreateDmURL = ChatRoomURL + "/dm-room"
    static let CreateGroupURL = SchoolURL + "/sub-room"
    static let ProjectURL = RootURL + "/project"
    static let CreateProjectURL = ProjectURL + "/create"
    static let UsersProjectURL = ProjectURL + "/user"
    static let FundProjectURL = ProjectURL + "/fund-project"
    static let BanksURL = ProjectURL + "/banks"
}


