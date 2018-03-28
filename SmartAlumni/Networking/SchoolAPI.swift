//
//  SchoolAPI.swift
//  SmartAlumni
//
//  Created by Jubril on 8/25/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON

class SchoolAPI {
    
    static let sharedManager = SchoolAPI()
    
    func getAllSchools(completionHandler: @escaping ([School]?, Error?) -> Void) {
        
        Alamofire.request(APIConstants.SchoolURL, method: .post).responseJSON {
            response in
            
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {
                    print("Error: Could not get json data")
                    completionHandler(nil, StringError("Error: Could not get json data"))
                    return
                }
                
                let schoolsTuple = Utilities.parseSchoolsFromJSON(json: JSON(jsonData))
                completionHandler(schoolsTuple.schools, schoolsTuple.error)
                
            case .failure(let error):
                print(error)
                completionHandler(nil, error)
            }
        }
    }
    
    func getAllUsersSchools(completionHandler: @escaping ([School]?, Error?) -> ()) {
        let realm = try! Realm()
        let user = realm.objects(User.self)[0]
        let params = ["_id" : user.uid]
        Alamofire.request(APIConstants.UserSchoolURL, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON {
            response in
            
            switch response.result {
            
            case .success:
                guard let jsonData = response.result.value else {
                    print("")
                    completionHandler(nil, StringError("Error: Could not get json data"))
                    return
                }
                let schoolsTuple = Utilities.parseSchoolsFromJSON(json: JSON(jsonData))
                completionHandler(schoolsTuple.schools, schoolsTuple.error)
                
            case .failure(let error):
                print(error)
                completionHandler(nil, error)
            }
            
        }
    }
    
    func fetchSchoolsByCategory(category: SchoolCategory, completionHandler: @escaping ([School]?, Error?) -> Void) {
    
        let parameters: [String: Any] = ["category" : category.rawValue]
        Alamofire.request(APIConstants.SchoolURL, method: .post, parameters: parameters).responseJSON {
            response in
            
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {
                    print("Error: could not get json data")
                    return
                }
                let schoolsTuple = Utilities.parseSchoolsFromJSON(json: JSON(jsonData))
                completionHandler(schoolsTuple.schools, schoolsTuple.error)
            case .failure(let error):
                print("Error\(error.localizedDescription)")
                completionHandler(nil, error)
            }
        }
    }
}
