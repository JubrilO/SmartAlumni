//
//  EditProfileViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 8/15/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import SwiftValidator
import SkyFloatingLabelTextField
import PhoneNumberKit

protocol EditProfileViewControllerInput: EditProfilePresenterOutput {
    
}

protocol EditProfileViewControllerOutput {
    func fetchEmailAddress()
    func saveProfile(firstName: String, lastName: String, username: String, phoneNumber: String, profileImage: UIImage)
}

final class EditProfileViewController: UIViewController {
    
    var output: EditProfileViewControllerOutput!
    var router: EditProfileRouterProtocol!
    
    @IBOutlet weak var phoneNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var usernameTextField: SkyFloatingLabelTextField!
    
    let validator = Validator()
    var textFields = [SkyFloatingLabelTextField]()
    
    
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
        hideNavigationBar()
        configureTextFields()
        output.fetchEmailAddress()
    }
    
    @IBAction func onProfileImageTap(_ sender: UITapGestureRecognizer) {
       
        presentActionSheet()
    }
    
    @IBAction func onBackgroundTap(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }
    
    @IBAction func onContinueButtonTouch(_ sender: UIButton) {
        continueButton.isHidden = true
        clearTextFieldErrors()
        activityIndicator.startAnimating()
        validator.validate(self)
    }
    
    func configureTextFields() {
        textFields = [firstNameTextField, lastNameTextField, phoneNumberTextField, usernameTextField, emailTextField, phoneNumberTextField]
        setupTextFieldFonts()
        validator.registerField(firstNameTextField, rules: [RequiredRule(), MinLengthRule()])
        validator.registerField(lastNameTextField, rules: [RequiredRule(), MinLengthRule()])
        validator.registerField(phoneNumberTextField, rules: [RequiredRule()])
        validator.registerField(usernameTextField, rules: [RequiredRule(), MinLengthRule()])
    }
    
    func setupTextFieldFonts() {
        let titleFont = UIFont.boldSystemFont(ofSize: 10)
        for field in textFields {
            field.titleFont = titleFont
        }
    }
    
    func clearTextFieldErrors() {
        for field in textFields {
            field.errorMessage = nil
        }
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
    
    func parsePhoneNumber(string: String) -> String? {
        let phoneNumberKit = PhoneNumberKit()
        do {
            let phoneNumber = try phoneNumberKit.parse(string)
            let formattedPhoneNumber = phoneNumberKit.format(phoneNumber, toType: .international)
            return formattedPhoneNumber
        }
        catch {
            phoneNumberTextField.errorMessage = "Invalid Phone Number"
            activityIndicator.stopAnimating()
            continueButton.isHidden = false
            return nil
        }
    }
    
}


// MARK: - EditProfilePresenterOutput

extension EditProfileViewController: ValidationDelegate {
    
    func validationSuccessful() {
        
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let phoneNumberString = phoneNumberTextField.text!
        let username = usernameTextField.text!
        var profileImage = profileImageView.image!
        if profileImageView.image! == Constants.PlaceholderImages.AddPhoto {
            profileImage = Constants.PlaceholderImages.ProfilePicture
        }
        
        if let phoneNumber = parsePhoneNumber(string: phoneNumberString) {
            output.saveProfile(firstName: firstName, lastName: lastName, username: username, phoneNumber: phoneNumber, profileImage: profileImage)
        }
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        activityIndicator.stopAnimating()
        continueButton.isHidden = false
        for (field, error ) in errors {
            if let field = field as? SkyFloatingLabelTextField {
                field.errorMessage = error.errorMessage
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
    
    func displayEmail(email: String) {
        emailTextField.text = email
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
