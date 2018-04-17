//
//  NewProjectRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 2/20/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol NewProjectRouterProtocol {

    weak var viewController: NewProjectViewController? { get }

    func navigateToVisibilityScene()
    func navigateToPhotoLibrary()
    func navigateToCamera()
    func navigateToAddBankScene()
    func navigateToSuccessScreen()
}

final class NewProjectRouter {

    weak var viewController: NewProjectViewController?


    // MARK: - Initializers

    init(viewController: NewProjectViewController?) {

        self.viewController = viewController
    }
}


// MARK: - NewProjectRouterProtocol

extension NewProjectRouter: NewProjectRouterProtocol {
    
    // MARK: - Navigation
    
    func navigateToSuccessScreen() {
        if  let successVC = viewController?.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.NewProjectCompletionScene) as? NewProjectCompletionVC {
            viewController?.navigationController?.pushViewController(successVC, animated: true)
            
        }
    }

    func navigateToVisibilityScene() {
        if  let visibilityVC = UIStoryboard(name: Constants.StoryboardNames.Polls, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.PollVisibilityScene) as? PollVisibilityViewController {
            visibilityVC.pollMode = false
            viewController?.navigationController?.pushViewController(visibilityVC, animated: true)
        }
        
    }
    
    func navigateToPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = viewController
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        viewController?.present(imagePicker, animated: true, completion: nil)
    }
    
    func navigateToCamera() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = viewController
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            viewController?.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have a camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func navigateToAddBankScene() {
        if let addBankVC = viewController?.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.AddBankScence) as? AddBankViewController {
            viewController?.navigationController?.pushViewController(addBankVC, animated: true)
        }
    }
}
