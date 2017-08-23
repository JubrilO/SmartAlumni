//
//  EditProfileRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 8/15/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol EditProfileRouterProtocol {
    
    weak var viewController: EditProfileViewController? { get }
    
    func routeToCamera()
    func routeToPhotoLibrary()
    func routeToSignUpCompletion()
}

final class EditProfileRouter {
    
    weak var viewController: EditProfileViewController?
    
    
    // MARK: - Initializers
    
    init(viewController: EditProfileViewController?) {
        
        self.viewController = viewController
    }
}


// MARK: - EditProfileRouterProtocol

extension EditProfileRouter: EditProfileRouterProtocol {
    
    
    // MARK: - Navigation
    
    func routeToCamera() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = viewController
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            viewController?.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func routeToPhotoLibrary() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = viewController
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        viewController?.present(imagePicker, animated: true, completion: nil)
    }
    
    func routeToSignUpCompletion() {
        if let signUpCompleteVC = viewController?.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.SignUpCompleteScene) {
            viewController?.navigationController?.pushViewController(signUpCompleteVC, animated: true)
        }
    }
}
