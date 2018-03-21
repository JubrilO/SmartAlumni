//
//  FundProjectViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 3/16/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Paystack
import EasyTipView
import SwiftValidator

protocol FundProjectViewControllerInput: FundProjectPresenterOutput {
    
}

protocol FundProjectViewControllerOutput {
    
    var project: Project {get set}
    func chargeCard(amount: Double, cardParams: PSTCKCardParams, vc: UIViewController)
}

final class FundProjectViewController: UIViewController, ValidationDelegate {
    
    var output: FundProjectViewControllerOutput!
    var router: FundProjectRouterProtocol!
    let paymentTextField = CardTextField()
    let validator = Validator()
    var activeToolTip: EasyTipView?
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var amountTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var paymentMethodButton: UIButton!
    @IBOutlet weak var illustrationBackground: UIView!
    
    // MARK: - Initializers
    
    init(configurator: FundProjectConfigurator = FundProjectConfigurator.sharedInstance) {
        
        super.init(nibName: nil, bundle: nil)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configure()
    }
    
    
    // MARK: - Configurator
    
    private func configure(configurator: FundProjectConfigurator = FundProjectConfigurator.sharedInstance) {
        
        configurator.configure(viewController: self)
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupFields()
        setupButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        showNavigationBar()
    }
    
    @IBAction func onBackButtonTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onPaymentMethodButtonClick(_ sender: UIButton) {
        toggleToolTip()
    }
    
    @IBAction func onNextButtonClick(_ sender: UIButton) {
        validator.validate(self)
    }
    
    func setupButton() {
        paymentMethodButton.layer.borderColor = Constants.Colors.softBlue.cgColor
        paymentMethodButton.layer.borderWidth = 1.0
    }
    
    func setupFields() {
        amountTextField.titleFont = UIFont.boldSystemFont(ofSize: 10)
        validator.registerField(amountTextField, rules: [RequiredRule(), FloatRule(message: "Please enter a valid amount")])
        paymentTextField.frame = CGRect(x: 40, y: illustrationBackground.bounds.height + 150, width: self.view.bounds.width - 80, height: 40)
        paymentTextField.borderWidth = 0
        paymentTextField.delegate = self
        let lineView = UIView(frame: CGRect(x: 40, y: illustrationBackground.bounds.height + 191, width: self.view.bounds.width - 80, height: 0.5))
        lineView.backgroundColor = UIColor.lightGray
        view.addSubview(paymentTextField)
        view.addSubview(lineView)
    }
    
    func toggleToolTip() {
        guard activeToolTip == nil else {
            activeToolTip?.dismiss()
            return
        }
        let toolTip = createToolTip()
        self.activeToolTip = toolTip
        toolTip.show(animated: true, forView: paymentMethodButton, withinSuperview: view)
    }
    
    func createToolTip() -> EasyTipView{
        var toolTip: EasyTipView
        setupToolTip()
        paymentMethodButton.titleLabel?.text == "Card" ? (toolTip = EasyTipView(text: "Bank", delegate: self)) : (toolTip = EasyTipView(text: "Card", delegate: self))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleToolTipTap))
        toolTip.addGestureRecognizer(tapGesture)
        return toolTip
    }
    
    func setupToolTip() {
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont.systemFont(ofSize: 14)
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = Constants.Colors.softBlue
        preferences.positioning.textHInset = 35
        preferences.drawing.cornerRadius = 3
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
        preferences.animating.dismissTransform = CGAffineTransform(translationX: 0, y: -15)
        preferences.animating.showInitialTransform = CGAffineTransform(translationX: 0, y: -15)
        preferences.animating.showInitialAlpha = 0
        preferences.animating.showDuration = 0.5
        preferences.animating.dismissDuration = 0.5
        EasyTipView.globalPreferences = preferences
    }
    
    @objc func handleToolTipTap() {
        print("Tap recognised")
        paymentMethodButton.titleLabel?.text == "Card" ? paymentMethodButton.setTitle("Bank", for: .normal) : paymentMethodButton.setTitle("Card", for: .normal)
        activeToolTip?.dismiss()
    }
    
    
    
    func validationSuccessful() {
        paymentTextField.isValid ? output.chargeCard(amount: Double(amountTextField.text!)!, cardParams: paymentTextField.cardParams, vc: self) : displayErrorModal(error: "Please enter valid card details")
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for error in errors {
            displayErrorModal(error:  error.1.errorMessage)
        }
    }
    
    
    // MARK: - Load data
}



// MARK: - FundProjectPresenterOutput

extension FundProjectViewController: FundProjectViewControllerInput {
    
    
    // MARK: - Display logic
    
    func displaySomething(viewModel: FundProjectViewModel) {
        
        // TODO: Update UI
    }
}

extension FundProjectViewController: PSTCKPaymentCardTextFieldDelegate {
    
}

extension FundProjectViewController: EasyTipViewDelegate {
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        activeToolTip = nil
    }
}
