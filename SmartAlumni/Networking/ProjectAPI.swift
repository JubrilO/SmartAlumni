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
}
