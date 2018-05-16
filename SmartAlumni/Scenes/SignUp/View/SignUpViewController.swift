//
//  SignUpViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 8/7/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import PhoneNumberKit
import SkyFloatingLabelTextField
import  SwiftValidator

protocol SignUpViewControllerInput: SignUpPresenterOutput {
    
}

protocol SignUpViewControllerOutput {
    var email: String? {get set}
    var validator: Validator {get}
    func signUpUser(email: String)
    func registerTextField(feild: UITextField)
    func validate()
}

final class SignUpViewController: UIViewController {
    
    var output: SignUpViewControllerOutput!
    var router: SignUpRouterProtocol!
    
    
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    let validator = Validator()
    
    // MARK: - Initializers
    
    init(configurator: SignUpConfigurator = SignUpConfigurator.sharedInstance) {
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    
    // MARK: - Configurator
    
    private func configure(configurator: SignUpConfigurator = SignUpConfigurator.sharedInstance) {
        configurator.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.registerTextField(feild: emailTextField)
        setupTextFields()
    }
    
    // MARK: - Actions
    
    @IBAction func onContinueButtonTouch(_ sender: UIButton) {
        activityIndicator.startAnimating()
        continueButton.isHidden = true
        output.email = emailTextField.text!
        output.validate()
    }
    
    @IBAction func onBackButtonTouch(_ sender: UIButton) {
        router.popViewController()
    }
    
    @IBAction func onTapGestureRecognised(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setupTextFields() {
        emailTextField.titleFont = UIFont.boldSystemFont(ofSize: 10)
    }
    
}


// MARK: - SignUpPresenterOutput

extension SignUpViewController: ValidationDelegate {
    
    func validationSuccessful() {
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        activityIndicator.stopAnimating()
        continueButton.isHidden = false
        for (_, error) in errors {
            self.displayErrorModal(error: error.errorMessage)
        }
    }
}

extension SignUpViewController: SignUpViewControllerInput {
    // MARK: - Display logic
    
    func presentOTPScene(user: User?) {
        activityIndicator.stopAnimating()
        continueButton.isHidden = false
        router.presentOTPScene(user: user)
    }
    
    func displayError(viewModel: SignUpViewModel) {
        activityIndicator.stopAnimating()
        continueButton.isHidden = false
        self.displayErrorModal(error: viewModel.errorMessage)
    }
    
}

