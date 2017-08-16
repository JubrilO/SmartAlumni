//
//  SignUpViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 8/7/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import PhoneNumberKit

protocol SignUpViewControllerInput: SignUpPresenterOutput {
    
}

protocol SignUpViewControllerOutput {
    var phoneNumber: String? {get set}
    func validate(textField: PhoneNumberTextField)
}

final class SignUpViewController: UIViewController {
    
    var output: SignUpViewControllerOutput!
    var router: SignUpRouterProtocol!
    
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: PhoneNumberTextField!
    
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
    
    
    // MARK: - Actions
    
    @IBAction func onContinueButtonTouch(_ sender: UIButton) {
        activityIndicator.startAnimating()
        continueButton.isHidden = true
        output.validate(textField: phoneNumberTextField)
    }
    
    @IBAction func onBackButtonTouch(_ sender: UIButton) {
        router.popViewController()
    }
    
    @IBAction func onTapGestureRecognised(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}


// MARK: - SignUpPresenterOutput

extension SignUpViewController: SignUpViewControllerInput {
    // MARK: - Display logic
    
    func presentOTPScene() {
        activityIndicator.stopAnimating()
        continueButton.isHidden = false
        router.presentOTPScene()
    }
    
    func displayError(viewModel: SignUpViewModel) {
        activityIndicator.stopAnimating()
        continueButton.isHidden = false
        self.displayErrorModal(error: viewModel.errorMessage)
    }
    
}
