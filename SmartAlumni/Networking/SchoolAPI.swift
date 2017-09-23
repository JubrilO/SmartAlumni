//
//  SchoolAPI.swift
//  SmartAlumni
//
//  Created by Jubril on 8/25/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SchoolAPI {
    
    static let sharedManager = SchoolAPI()
    
    func getAllSchools(completionHandler: @escaping ([School]?, String?) -> Void) {
        
        Alamofire.request(APIConstants.SchoolURL, method: .post).responseJSON {
            response in
            
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {
                    print("Error: Could not get json data")
                    return
                }
                let schoolsTuple = Utilities.parseSchoolsFromJSON(json: JSON(jsonData))
                completionHandler(schoolsTuple.schools, schoolsTuple.error)
                
            case .failure(let error):
                print(error)
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
}
