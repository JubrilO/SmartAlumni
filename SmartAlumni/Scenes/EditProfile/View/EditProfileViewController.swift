//
//  EditProfileViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 8/15/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import SwiftValidator

protocol EditProfileViewControllerInput: EditProfilePresenterOutput {
    
}

protocol EditProfileViewControllerOutput {
    
    func saveProfile(firstName: String, lastName: String, username: String, email: String, profileImage: UIImage)
}

final class EditProfileViewController: UIViewController {
    
    var output: EditProfileViewControllerOutput!
    var router: EditProfileRouterProtocol!
    
    @IBOutlet weak var usernameTextField: UnderlinedTextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var firstNameTextField: UnderlinedTextField!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UnderlinedTextField!
    @IBOutlet weak var lastNameTextField: UnderlinedTextField!
    
    let validator = Validator()
    
    
    // MARK: - Initializers
    
    init(configurator: EditProfileConfigurator = EditProfileConfigurator.sharedInstance) {
        
        super.init(nibName: nil, bundle: nil)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configure()
    }
    
    
    // MARK: - Configurator
    
    private func configure(configurator: EditProfileConfigurator = EditProfileConfigurator.sharedInstance) {
        
        configurator.configure(viewController: self)
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureTextFields()
    }
    
    @IBAction func onProfileImageTap(_ sender: UITapGestureRecognizer) {
       
        presentActionSheet()
    }
    
    @IBAction func onBackgroundTap(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }
    
    @IBAction func onContinueButtonTouch(_ sender: UIButton) {
        continueButton.isHidden = true
        activityIndicator.startAnimating()
        validator.validate(self)
    }
    
    func configureTextFields() {
        
        validator.registerField(firstNameTextField, rules: [RequiredRule()])
        validator.registerField(lastNameTextField, rules: [RequiredRule()])
        validator.registerField(emailTextField, rules: [RequiredRule(), EmailRule()])
        validator.registerField(usernameTextField, rules: [RequiredRule()])
        phoneNumberLabel.text = UserDefaults.standard.string(forKey: Constants.UserDefaults.PhoneNumber)
    }
    
    
    func presentActionSheet() {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.router.routeToCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.router.routeToPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}


// MARK: - EditProfilePresenterOutput

extension EditProfileViewController: ValidationDelegate {
    
    func validationSuccessful() {
        
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let email = emailTextField.text!
        let username = usernameTextField.text!
        var profileImage = profileImageView.image!
        if profileImageView.image! != Constants.PlaceholderImages.AddPhoto {
            profileImage = Constants.PlaceholderImages.ProfilePicture
        }
        output.saveProfile(firstName: firstName, lastName: lastName, username: username, email: email, profileImage: profileImage)
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        activityIndicator.stopAnimating()
        continueButton.isHidden = false
        for (field, _ ) in errors {
            if let field = field as? UnderlinedTextField {
                field.borderColor = UIColor.red
            }
        }
    }
}

extension EditProfileViewController: EditProfileViewControllerInput {
    
    // MARK: - Display logic
   
    func displayError(errorMessage: String) {
        continueButton.isHidden = false
        activityIndicator.stopAnimating()
        self.displayErrorModal(error: errorMessage)
    }

    func presentNextScene() {
        router.routeToSignUpCompletion()
    }

}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.image = selectedImage
        }
        
        if let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}
