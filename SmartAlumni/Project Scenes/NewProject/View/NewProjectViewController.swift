//
//  NewProjectViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 2/20/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftValidator

protocol NewProjectViewControllerInput: NewProjectPresenterOutput {
    
}

protocol NewProjectViewControllerOutput {
    
    func createProject(title: String, desc: String, amount: String, startDate: String, endDate: String, milestones: [Milestone], image: UIImage?)

    var accountDetails: AccountDetails? {get set}
    var targetSchool: School? {get set}
    var targetFaculties: [Faculty] {get set}
    var targetDepartments: [Department] {get set}
    var targetSets: [String] {get set}
    var timeInterval: Duration {get set}
}

final class NewProjectViewController: UIViewController, ValidationDelegate {
    
    var output: NewProjectViewControllerOutput!
    var router: NewProjectRouterProtocol!
    
    var day = ""
    var hour = ""
    var min = ""
    var milestoneCount = 1
    
    var days = [String]()
    var hours = [String]()
    var minutes = [String]()
    let validator = Validator()
    var activeField = UITextField()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var visiblityLabel: UILabel!
    @IBOutlet weak var AccounNumberLabel: UILabel!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var milestoneTableView: UITableView!
    @IBOutlet weak var projectAccount: UILabel!
    @IBOutlet weak var projectVisibility: UILabel!
    @IBOutlet weak var goalTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var descriptionTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var titleTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startDateTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var endDateTextField: SkyFloatingLabelTextField!
    
    // MARK: - Initializers
    
    init(configurator: NewProjectConfigurator = NewProjectConfigurator.sharedInstance) {
        
        super.init(nibName: nil, bundle: nil)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configure()
    }
    
    
    // MARK: - Configurator
    
    private func configure(configurator: NewProjectConfigurator = NewProjectConfigurator.sharedInstance) {
        
        configurator.configure(viewController: self)
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        milestoneTableView.tableFooterView = UIView()
        milestoneTableView.delegate = self
        milestoneTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if view.bounds.height < 667 {
            scrollViewHeightConstraint.constant = 130
        }
        if let selectedBank = output.accountDetails {
            AccounNumberLabel.text = selectedBank.bank.name
        }
        if let targetSchool = output.targetSchool {
            visiblityLabel.text = targetSchool.name
        }
        setupTextFields()
    }
    
    @IBAction func onNextButtonTap(_ sender: UIBarButtonItem) {
        diplayActivityIndicator()
        validator.validate(self)
    }
    
    @IBAction func onBackButtonTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddPhotoButtonTap(_ sender: UIButton) {
        presentActionSheet()
    }
    
    @IBAction func onProjectVisibiltyCellTap(_ sender: UITapGestureRecognizer) {
        router.navigateToVisibilityScene()
    }
    
    @IBAction func onProjectAccountCellTap(_ sender: UITapGestureRecognizer) {
        router.navigateToAddBankScene()
    }
    
    func presentActionSheet() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.router.navigateToCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.router.navigateToPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func setupTextFields() {
        titleTextField.titleFormatter = {(text:String) -> String in return text}
        descriptionTextField.titleFormatter = {(text:String) -> String in return text}
        goalTextField.titleFormatter = {(text:String) -> String in return text}
        startDateTextField.titleFormatter = {(text:String) -> String in return text}
        endDateTextField.titleFormatter = {(text:String) -> String in return text}
        validator.registerField(titleTextField, errorLabel: titleTextField.titleLabel, rules: [RequiredRule()])
        validator.registerField(descriptionTextField, errorLabel: descriptionTextField.titleLabel, rules: [RequiredRule()])
        validator.registerField(goalTextField, errorLabel: goalTextField.titleLabel, rules: [RequiredRule(), FloatRule()])
        validator.registerField(startDateTextField, rules: [RequiredRule()])
        validator.registerField(endDateTextField, rules: [RequiredRule()])
        //let milsetoneCell = milestoneTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? OptionCell
        //validator.registerField(milsetoneCell.optionField, rules: [RequiredRule()])
        startDateTextField.delegate = self
        endDateTextField.delegate = self
    }
    
    func validationSuccessful() {
        if output.accountDetails != nil && output.targetSchool != nil {

            output.createProject(title: titleTextField.text!, desc: descriptionTextField.text!, amount: goalTextField.text!, startDate: startDateTextField.text!, endDate: endDateTextField.text!, milestones: getMilestones(), image: imageView.image)
        }
        else {
            hideActivityIndicator()
            if output.accountDetails == nil {
                displayErrorModal(error: "Please enter account details for this project")
            }
            else if output.targetSchool == nil {
                displayErrorModal(error: "Please select the school you want to participate in this project")
            }
            else {
                displayErrorModal(error: "Please select the school you want to participate in this project and enter the account details for this project")
            }
        }
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        print("Validation failed")
        hideActivityIndicator()
        for (field, error) in errors {
            if let field = field as? SkyFloatingLabelTextField {
                field.errorMessage = error.errorMessage
            }
        }
    }
    
    func diplayActivityIndicator() {
        activityIndicator.color = UIColor.black
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        let nextBarButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(onNextButtonTap(_:)))
        nextBarButton.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = nextBarButton
    }
    
    func getMilestones() -> [Milestone] {
        var milestones  = [Milestone]()
        
        guard let milestoneCells = milestoneTableView.visibleCells as? [OptionCell] else {return milestones}
        
        for milestoneCell in milestoneCells {
            if milestoneCell.optionField.text != "" {
                milestones.append(Milestone(name: milestoneCell.optionField.text!))
            }
        }
        return milestones
    }
    
    func setupTextFieldValidation() {
        validator.registerField(titleTextField, rules: [RequiredRule(), MaxLengthRule(length: 20)])
        validator.registerField(descriptionTextField, rules: [RequiredRule(), MaxLengthRule(length: 25)])
        validator.registerField(goalTextField, rules: [RequiredRule(), FloatRule(message: "Please enter a valid amount. (Without commas or currency)")])
    }
    
    @objc func addOption() {
        if milestoneCount < 8 {
            milestoneCount = milestoneCount + 1
            view.layoutIfNeeded()
            tableViewHeightConstraint.constant = CGFloat(64 * milestoneCount)
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()
                
            })
            milestoneTableView.beginUpdates()
            milestoneTableView.insertRows(at: [IndexPath.init(row: milestoneCount - 1, section: 0)], with: .top)
            milestoneTableView.endUpdates()
            scrollViewHeightConstraint.constant += 64
            hideAddButtons()
            delayWithSeconds(0.1, completion: {self.scrollView.scrollToBottom()})
        }
    }
    
    @objc func datePickeValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        activeField.text = dateFormatter.string(from: sender.date)
    }
    
    func hideAddButtons() {
        for cell in milestoneTableView.visibleCells as! [OptionCell]{
            if cell != milestoneTableView.visibleCells.last {
                cell.addOptionButton.isHidden = true
            }
        }
    }
}


// MARK: - NewProjectPresenterOutput

extension NewProjectViewController: NewProjectViewControllerInput {
    
    func displayError(_ string: String?) {
        hideActivityIndicator()
        displayErrorModal(error: string)

    }
    
    func displaySuccessScreen() {
        hideActivityIndicator()
        router.navigateToSuccessScreen()

    }
}

extension NewProjectViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
        print("Begin Editing")
        if textField == startDateTextField || textField == endDateTextField {
            let inputView = UIDatePicker()
            inputView.minimumDate = Date()
            inputView.datePickerMode = .date
            textField.inputView = inputView
            inputView.addTarget(self, action: #selector(datePickeValueChanged), for: .valueChanged)
        }
    }
}


extension NewProjectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return milestoneCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell") as! OptionCell
        cell.optionField.placeholder = "Milestone " + String(1 + indexPath.row)
        if indexPath.row == 0 {
            print("Regitering milestone field")
            validator.registerField(cell.optionField, rules: [RequiredRule]())
        }
        
        cell.optionField.titleFormatter = { (text:String) -> String in return text }
        cell.addOptionButton.isHidden = true
        cell.addOptionButton.addTarget(self, action: #selector(addOption), for: .touchUpInside)
        if indexPath.row == (milestoneCount-1) {
            cell.addOptionButton.isHidden = false
        }
        return cell
    }
}

extension NewProjectViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = selectedImage
        }
        
        if let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
