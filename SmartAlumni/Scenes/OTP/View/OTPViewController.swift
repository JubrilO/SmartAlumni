//
//  OTPViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 8/13/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import SwiftValidator

protocol OTPViewControllerInput: OTPPresenterOutput {
    
}

protocol OTPViewControllerOutput {
    
    var email: String? {get set}
    func verifyOTP(otp: String)
    func fetchPhoneNumber()
    func resendOTP()
}

final class OTPViewController: UIViewController {
    
    var output: OTPViewControllerOutput!
    var router: OTPRouterProtocol!
    let validator = Validator()
    var timer = Timer()
    var totalTime = 60
    
    @IBOutlet weak var resendOTPButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var textField5: UnderlinedTextField!
    @IBOutlet weak var textField4: UnderlinedTextField!
    @IBOutlet weak var textField3: UnderlinedTextField!
    @IBOutlet weak var textField2: UnderlinedTextField!
    @IBOutlet weak var textField1: UnderlinedTextField!
    @IBOutlet weak var confirmationLabel: UILabel!
    
    // MARK: - Initializers
    
    init(configurator: OTPConfigurator = OTPConfigurator.sharedInstance) {
        
        super.init(nibName: nil, bundle: nil)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configure()
    }
    
    
    // MARK: - Configurator
    
    private func configure(configurator: OTPConfigurator = OTPConfigurator.sharedInstance) {
        
        configurator.configure(viewController: self)
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureTextFields()
        configureButtons()
        hideNavigationBar()
        getUserPhoneNumber()
    }
    
    @IBAction func onContinueButtonTouch(_ sender: UIButton) {
        
        validator.validate(self)
    }
    
    @IBAction func onBackButtonTouch(_ sender: UIButton) {
        
        router.popViewController()
    }
    
    @IBAction func onBackgroundTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func onResendOTPButtonTap(_ sender: UIButton) {
        sender.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateResendButton), userInfo: nil, repeats: true)
        output.resendOTP()
    }
    
    @objc func updateResendButton() {
        resendOTPButton.setTitle("Resend Code (\(totalTime))", for: .normal)
        if totalTime != 0 {
            totalTime -= 1
        } else {
            resendOTPButton.isEnabled = true
            resendOTPButton.setTitle("Resend Code", for: .normal)
            totalTime = 60
            endTimer()
        }
    }
    
    func endTimer() {
        timer.invalidate()
    }
    
    func configureButtons() {
        resendOTPButton.setTitle("Send new code", for: .normal)
    }
    
    func configureTextFields() {
        
        validator.registerField(textField1, rules: [RequiredRule()])
        validator.registerField(textField2, rules: [RequiredRule()])
        validator.registerField(textField3, rules: [RequiredRule()])
        validator.registerField(textField4, rules: [RequiredRule()])
        validator.registerField(textField5, rules: [RequiredRule()])
    }
    
    func getUserPhoneNumber() {
        
        output.fetchPhoneNumber()
    }
    
    func getOTP() -> String {
        
        let otp = textField1.text! + textField2.text! + textField3.text! + textField4.text! + textField5.text!
        return otp
    }
    
}

// MARK: - Validation Delegate

extension OTPViewController: ValidationDelegate {
    
    func validationSuccessful() {
        
        let otp = getOTP()
        output.verifyOTP(otp: otp)
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        
        for (field, _ ) in errors {
            if let field = field as? UnderlinedTextField {
                field.borderColor = UIColor.red
            }
        }
    }
}


// MARK: - OTPPresenterOutput

extension OTPViewController: OTPViewControllerInput {
    
    
    // MARK: - Display logic
    
    func presentNextScene() {
        router.routeToEditProfile()
    }
    
    func displayError(viewModel: OTPViewModel) {
        
        self.displayErrorModal(error: viewModel.errorMessage)
    }
    
    func displayOTPCopy(copy: String) {
        self.confirmationLabel.text = copy
    }
}

extension OTPViewController: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.count > 0 {
            let nextTag = textField.tag + 1
            
            let nextResponder = textField.superview?.viewWithTag(nextTag)
            
            if nextResponder == nil {
                view.endEditing(true)
            }
            textField.text = string
            nextResponder?.becomeFirstResponder()
            return false
        }
        else if (textField.text!.count >= 1  && string.count == 0) {
            let previousTag = textField.tag - 1
            
            var previousResponder = textField.superview?.viewWithTag(previousTag)
            
            if (previousResponder == nil){
                previousResponder = textField.superview?.viewWithTag(1)
            }
            textField.text = ""
            previousResponder?.becomeFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Constants.Colors.borderColor.cgColor
    }
}
