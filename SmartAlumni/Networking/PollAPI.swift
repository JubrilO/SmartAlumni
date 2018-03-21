//
//  PollsAPI.swift
//  SmartAlumni
//
//  Created by Jubril on 9/25/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON

class PollAPI {
    static let sharedManager =  PollAPI()
    
    func getAllPolls(completionHandler:@escaping ([Poll]?, String?) -> ()) {
        let realm = try! Realm()
        if let user = realm.objects(User.self).first {
            var schooldeetsJSONArray = [[String : Any]]()
            for schoolDeets in user.schoolDetailsList {
                schooldeetsJSONArray.append(schoolDeets.toJSON())
            }
            let params : [String : Any] = ["_id": Array(user.schoolIds), "school_details" : schooldeetsJSONArray ]
            print(params)
            let req = Alamofire.request(APIConstants.UsersPollURL, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON {
                response in
                guard response.result.error == nil else {return}
                
                switch response.result {
                case .success:
                    guard let jsonData = response.result.value else {return}
                    let pollsTuple = Utilities.parsePollsFromJSON(json: JSON(jsonData))
                    Utilities.addPollsToRealm(pollsTuple.polls)
                    completionHandler(pollsTuple.polls, pollsTuple.error)
                case .failure(let error):
                    print(error)
                    completionHandler(nil, error.localizedDescription)
                }
            }
            print(req)
        }
    }
    
    func votePoll(pollID: String, userID: String, optionIndex: Int, completionHandler: @escaping (Bool, String?) -> ()){
        let parameters = [ "id" : pollID, "voter" : ["user" : userID, "option" : optionIndex ]] as [String : Any]
        print("Parameters \(parameters)")
        Alamofire.request(APIConstants.VotePollURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{
            response in
            
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {return}
                let successTuple = Utilities.parseSuccessFromJSON(json: JSON(jsonData))
                completionHandler(successTuple.success, successTuple.error)
            case .failure(let error):
                print(error)
                completionHandler(false, error.localizedDescription)
            }
        }
    }
    
    func createPoll(title: String, question: String, options: [Option], startDate: String, duration: Int, visibility: [String : Any],  completionHandler: @escaping (Bool?, String?) -> ()) {
        
        let parameters = Utilities.generatePollDict(title: title, question: question, options: options, startDate: startDate, duration: duration, visibility: visibility)
        print(parameters)
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

