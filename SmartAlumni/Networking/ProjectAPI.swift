//
//  ProjectAPI.swift
//  SmartAlumni
//
//  Created by Jubril on 3/14/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class ProjectAPI {
    static let sharedManager = ProjectAPI()
    
    func createProject(title: String, desc: String, amount: String, startDate: Date, endDate: Date, milestones: [Milestone], visibility: [String : Any], account: AccountDetails, image: UIImage?, completionHandler: @escaping(Project?, Error?) -> Void) {
        if let image = image {
            UserAPI.sharedManager.saveImageToFirebase(image: image , quality: .medium) {
                url, error in
                
                guard  error == nil else {
                    completionHandler(nil, error)
                    return
                }
                if let url = url {
                    let params = Utilities.generateProjectDict(title: title, desc: desc, amount: amount, startDate: startDate, endDate: endDate, milestones: milestones, visibility: visibility, account: account, image: url)
                    Alamofire.request(APIConstants.CreateProjectURL, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{
                        response in
                        debugPrint(response)
                        switch response.result {
                        case .success:
                            guard let jsonData = response.result.value else {
                                return
                            }
                            let projectTuple = Utilities.parseProjectFromJSON(json: JSON(jsonData))
                            completionHandler(projectTuple.project, projectTuple.error)
                        case .failure(let error):
                            print("Serialization Error \(error)")
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            
        }
            
        else {
            let params = Utilities.generateProjectDict(title: title, desc: desc, amount: amount, startDate: startDate, endDate: endDate, milestones: milestones, visibility: visibility, account: account)
            Alamofire.request(APIConstants.CreateProjectURL, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{
                response in
                debugPrint(response)
                switch response.result {
                case .success:
                    guard let jsonData = response.result.value else {
                        return
                    }
                    let projectTuple = Utilities.parseProjectFromJSON(json: JSON(jsonData))
                    completionHandler(projectTuple.project, projectTuple.error)
                case .failure(let error):
                    print("Serialization Error \(error)")
                    completionHandler(nil, error)
                }
            }
        }
    }
    
    func getAllProjects(completionHandler: @escaping ([Project]?, Error?) -> Void) {
        let realm = try! Realm()
        let user = realm.objects(User.self)[0]
        var schooldeetsJSONArray = [[String : Any]]()
        for schoolDeets in user.schoolDetailsList {
            schooldeetsJSONArray.append(schoolDeets.toJSON())
        }
        let params : [String : Any] = ["_id": Array(user.schoolIds), "school_details" : schooldeetsJSONArray ]
        
        Alamofire.request(APIConstants.UsersProjectURL, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON {
            response in
            
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {
                    print("Error: Could not fetch json data")
                    return
                }
                print(jsonData)
                let projectsTuple = Utilities.parseProjectsFromJSON(json: JSON(jsonData))
                completionHandler(projectsTuple.projects, projectsTuple.error)
                
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
    
    func fundProject(amount: Int, project: Project, transactionRef: String, completionHandler: @escaping (Bool, String?) -> ()) {
        let realm = try! Realm()
        let user = realm.objects(User.self)[0]
        let parameters: [String : Any] = ["email": user.email, "user_id": user.uid , "project_id":project.id, "reference":transactionRef, "amount":String(amount)]
        Alamofire.request(APIConstants.FundProjectURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
            response in
            
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {
                    print("Error: Could not fetch json data")
                    return
                }
                let json = JSON(jsonData)
                print(json)
                let successTuple =  Utilities.parseTransactionRefStatusFromJSON(json: JSON(jsonData))
                completionHandler(successTuple.success, successTuple.error)
            case .failure(let error):
                print(error)
                completionHandler(false, error.localizedDescription)
            }
            
        }
    }
    
    func getAllBanks(completionHandler: @escaping ([Bank]?, Error?) -> ()) {
        Alamofire.request(APIConstants.BanksURL).responseJSON {
            response in
            
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {
                    print("Error: Could not fetch JSON data")
                    return
                }
                let json = JSON(jsonData)
                let banksTuple = Utilities.parseBanksFromJSON(json: json)
                completionHandler(banksTuple.banks, banksTuple.error)
            case .failure(let error):
                completionHandler(nil, error)
                print(error)
            }
        }
    }
}
