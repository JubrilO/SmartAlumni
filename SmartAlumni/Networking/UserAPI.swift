//
//  File.swift
//  SmartAlumni
//
//  Created by Jubril on 8/7/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Locksmith

class UserAPI {
    
    static let sharedManager = UserAPI()
    
    func GenerateOTP(phoneNumber: String, completionHandler: @escaping (_ otp: String?, _ error: Error?) -> Void ) {
        
        Alamofire.request(APIConstants.OtpURL, method: .post, parameters: ["phone_number" : phoneNumber], encoding: JSONEncoding.default).responseJSON {
            response in
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {
                    return
                }
                print(jsonData)
                let otp = Utilities.parseOTPFromJSON(json: JSON(jsonData))
                completionHandler(otp, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func signUpUser(phoneNumber: String, completionHandler: @escaping (String?, String?) -> Void ) {
        
        
        Alamofire.request(APIConstants.SignUpURL, method: .post, parameters: ["phone_number" : phoneNumber], encoding: JSONEncoding.default).responseJSON {
            response in
            print(response.result)
            switch response.result {
            case .success:
                print("success")
                guard let jsonData = response.result.value else {
                    return
                }
                let uidTupule = Utilities.parseUIDFromJSON(json: JSON(jsonData))
                if let uid = uidTupule.0 {
                    //try! Locksmith.updateData(data: ["uid" : uid], forUserAccount: Constants.SmartAlumniUser)
                    UserDefaults.standard.set(uid, forKey: Constants.UserDefaults.UID)
                }
                completionHandler(uidTupule.0, uidTupule.1)
            case .failure(let error):
                print(error)
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
    
    func updateProfile(parameters: [String : Any], completionHandler: @escaping (User?, String?) -> Void ) {
        
        Alamofire.request(APIConstants.UpdateProfileURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
            response in
            
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {
                    return
                }
                let userTupule = Utilities.parseUserFromJSON(json: JSON(jsonData))
                completionHandler(userTupule.user, userTupule.error)
            case .failure(let error):
                print(error)
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
    
    func joinSchool(schoolID: String, facultyID: String, departmentID: String, set: Int, completionHandler: @escaping (Bool, String?) -> ()) {
        
        if let userID = UserDefaults.standard.string(forKey: Constants.UserDefaults.UID) {
            let parameters = ["_id" : userID,
                              "school_details" :
                                [
                                    "school" : schoolID,
                                    "faculty" : facultyID,
                                    "deparment" : departmentID,
                                    "set" : set
                ]
                ] as [String : Any]
            
            print("Making network call")
            Alamofire.request(APIConstants.JoinSchoolURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
                response in
                
                switch response.result {
                case .success:
                    guard let jsonData = response.result.value else {
                        completionHandler(false, "Could not fetch JSON Data")
                        return
                    }
                    let successTuple = Utilities.parseSuccessFromJSON(json: JSON(jsonData))
                    successTuple.0 ? completionHandler(true, nil) : completionHandler(false, "\(successTuple.1 ?? "Error")")
                    
                case .failure(let error):
                    print(error)
                    completionHandler(false, "\(error)")
                }
                
            }
        }
        else {
            print("no Uid saved")
        }
    }
    
}
