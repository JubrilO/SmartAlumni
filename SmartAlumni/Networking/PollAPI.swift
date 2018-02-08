//
//  PollsAPI.swift
//  SmartAlumni
//
//  Created by Jubril on 9/25/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PollAPI {
    static let sharedManager =  PollAPI()
    
    func getAllPolls(completionHandler:@escaping ([Poll]?, String?) -> ()) {
        Alamofire.request(APIConstants.CreatePollURL, method: .post).responseJSON {
            response in
            guard response.result.error == nil else {return}
            
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {return}
                let pollsTuple = Utilities.parsePollsFromJSON(json: JSON(jsonData))
                completionHandler(pollsTuple.polls, pollsTuple.error)
            case .failure(let error):
                print(error)
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
    
    func votePoll(pollID: String, userID: String, optionIndex: Int, completionHandler: @escaping (Bool?, String?) -> ()){
        let parameters = [ "id" : userID, "voter" : ["user" : userID, "option" : optionIndex ]] as [String : Any]
        Alamofire.request(APIConstants.VotePollURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{
            response in
            
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {return}
                let successTuple = Utilities.parseSuccessFromJSON(json: JSON(jsonData))
                completionHandler(successTuple.success, successTuple.error)
            case .failure(let error):
                print(error)
                completionHandler(nil, error.localizedDescription)
            }
            
        }
    }
    
    func createPoll(title: String, question: String, options: [Option], startDate: String, endDate: String, visibility: [String : Any],  completionHandler: @escaping (Bool?, String?) -> ()) {
        let parameters = Utilities.generatePollDict(title: title, question: question, options: options, startDate: startDate, endDate: endDate, visibility: visibility)
        Alamofire.request(APIConstants.CreatePollURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
            response in
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {return}
                let successTuple = Utilities.parseSuccessFromJSON(json: JSON(jsonData))
                completionHandler(successTuple.success, successTuple.error)
            case .failure(let error):
                print(error)
                completionHandler(nil, error.localizedDescription)
            }
            
        }
    }
}

