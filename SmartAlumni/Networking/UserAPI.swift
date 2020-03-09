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
import RealmSwift
import FirebaseStorage

class UserAPI {
    
    static let sharedManager = UserAPI()
    
    func GenerateOTP(email: String, completionHandler: @escaping (_ otp: String?, _ error: Error?) -> Void ) {
        
        Alamofire.request(APIConstants.OtpURL, method: .post, parameters: ["email" : email], encoding: JSONEncoding.default).responseJSON {
            response in
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {
                    completionHandler(nil, response.result.error)
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
    
    func signUpUser(email: String, completionHandler: @escaping (User?, Error?) -> Void ) {
        
        
        Alamofire.request(APIConstants.SignUpURL, method: .post, parameters: ["email" : email], encoding: JSONEncoding.default).responseJSON {
            response in
            print(response.result)
            switch response.result {
            case .success:
                print("success")
                guard let jsonData = response.result.value else {
                    completionHandler(nil, response.result.error)
                    return
                }
                let uidTupule = Utilities.parseUIDFromJSON(json: JSON(jsonData))
                if let uid = uidTupule.0 {
                    UserDefaults.standard.set(uid, forKey: Constants.UserDefaults.UID)
                }
                let userTuple = Utilities.parseUserFromJSON(json: JSON(jsonData))
                completionHandler(userTuple.user, userTuple.error)
            case .failure(let error):
                print(error)
                completionHandler(nil, error)
            }
        }
    }
    
    func saveImageToFirebase(image: UIImage, quality: UIImage.JPEGQuality, completionHandler: @escaping (String?, Error?) -> () ) {
        
        guard let mediumQualityImageData = image.jpeg(quality) else {
            print("No image Data")
            return
        }
        let imageID = UUID().uuidString
        print(imageID)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let imageRef = Storage.storage().reference().child("profile_images/\(imageID).jpg")
        let task = imageRef.putData(mediumQualityImageData, metadata: metadata) {
            (metadata, error) in
            guard let metadata = metadata else {
                print(error?.localizedDescription ?? "")
                completionHandler(nil, error)
                return
            }
            print("Upload Complete")
            let urlString = metadata.downloadURL()?.absoluteString
            completionHandler(urlString, error)
        }
        task.observe(.progress) { snapshot in
            // Download reported progress
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            print("Percentage Completion: \(percentComplete)")
        }
        
        
    }
    
    func updateProfile(parameters: [String : Any], completionHandler: @escaping (User?, Error?) -> Void ) {
        
        Alamofire.request(APIConstants.UpdateProfileURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
            response in
            
            switch response.result {
            case .success:
                guard let jsonData = response.result.value else {
                    completionHandler(nil, response.result.error)
                    return
                }
                print(JSON(jsonData))
                let userTupule = Utilities.parseUserFromJSON(json: JSON(jsonData))
                completionHandler(userTupule.user, userTupule.error)
            case .failure(let error):
                print(error)
                completionHandler(nil, error)
            }
        }
    }
    
    func joinSchool(schoolID: String, facultyID: String? = nil, departmentID: String? = nil, set: Int, completionHandler: @escaping (Bool, String?) -> ()) {
        
        guard let userID = UserDefaults.standard.string(forKey: Constants.UserDefaults.UID) else { completionHandler(false, "No UID saved"); return }
        var parameters = [String: Any]()
        let realm = try! Realm()
        if let facultyID = facultyID, let departmentID = departmentID
        {
            
            if let user = realm.objects(User.self).first {
                let schoolDetails = SchoolDetails(schoolID: schoolID, facultyID: facultyID, departmentID: departmentID, set: set)
                try! realm.write {
                    user.schoolIds.append(schoolID)
                    user.schoolDetailsList.append(schoolDetails)
                }
            }
            parameters = ["_id" : userID,
                          "school_details" :
                            [
                                "school" : schoolID,
                                "faculty" : facultyID,
                                "deparment" : departmentID,
                                "school_set" : set
                ]
            ]
        }
        else{
            if let user = realm.objects(User.self).first {
                let schoolDetails = SchoolDetails(schoolID: schoolID, set: set)
                try! realm.write {
                    user.schoolIds.append(schoolID)
                    user.schoolDetailsList.append(schoolDetails)
                }
            }
            parameters =
                ["_id" : userID,
                 "school_details" :
                    [
                        "school" : schoolID,
                        "school_set" : set
                    ]
            ]
        }
        
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
    
}
