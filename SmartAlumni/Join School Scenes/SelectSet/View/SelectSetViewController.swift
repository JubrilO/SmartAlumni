//
//  SelectSetViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 8/29/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import SwiftValidator
import Kingfisher

protocol SelectSetViewControllerInput: SelectSetPresenterOutput {
    
}

protocol SelectSetViewControllerOutput {
    
    var selectedDepartment: Department? {get set}
    var selectedFaculty: Faculty? {get set}
    var selectedSet: Int? {get set}
    var school: School {get set}
    func updatePickerOptions(optionType: OptionType)
    func joinSet()
}

final class SelectSetViewController: UIViewController {
    
    var output: SelectSetViewControllerOutput!
    var router: SelectSetRouterProtocol!
    
    @IBOutlet weak var lineDividerView: UIView!
    @IBOutlet weak var arrowImageView2: UIImageView!
    @IBOutlet weak var arrowImageView1: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var schoolImageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var facultyTextField: UnderlinedTextField!
    @IBOutlet weak var departmentTextField: UnderlinedTextField!
    @IBOutlet weak var setTextField: UnderlinedTextField!
    
    let pickerView = UIPickerView()
    let validator = Validator()
    var pickerOptions = [String]()
    var activeField: UnderlinedTextField?
    
    
    // MARK: - Initializers
    
    init(configurator: SelectSetConfigurator = SelectSetConfigurator.sharedInstance) {
        
        super.init(nibName: nil, bundle: nil)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configure()
    }
    
    
    // MARK: - Configurator
    
    private func configure(configurator: SelectSetConfigurator = SelectSetConfigurator.sharedInstance) {
        
        configurator.configure(viewController: self)
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = output.school.name
        if let imageURL = output.school.imageURL {
            let url = URL(string: imageURL)
            schoolImageView.kf.setImage(with: url)
        }
        setupTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayTextFieldData()
    }
    
    @IBAction func onFacultyTextFieldTap(_ sender: UITapGestureRecognizer) {
        print("Faculty text field....")
    }
    
    @IBAction func onBackgroundTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
    }
    
    @IBAction func onDeparmentTextFieldTap(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func onContinueButtonTouch(_ sender: UIButton) {
        view.endEditing(true)
        validator.validate(self)
        continueButton.isHidden = true
        activityIndicator.startAnimating()
    }
    
    // MARK: - Load data
    
    func setupTextFields() {
        pickerView.delegate = self
        pickerView.dataSource = self
        setTextField.inputView = pickerView
        validator.registerField(setTextField, rules: [RequiredRule()])
        if output.school.category == SchoolCategory.Primary.rawValue ||  output.school.category == SchoolCategory.Secondary.rawValue {
            arrowImageView1.isHidden = true
            arrowImageView2.isHidden = true
            facultyTextField.isHidden = true
            departmentTextField.isHidden = true
        }
        else {
        
        validator.registerField(facultyTextField, rules: [RequiredRule()])
        validator.registerField(departmentTextField, rules: [RequiredRule()])
        }
    }
    
    func displayTextFieldData() {
        if let selectedDepartment = output.selectedDepartment {
            departmentTextField.text = selectedDepartment.name
        }
        if let selectedFaculty = output.selectedFaculty {
            facultyTextField.text = selectedFaculty.name
        }
    }
}

extension SelectSetViewController: ValidationDelegate {
    
    func validationSuccessful() {
        output.joinSet()
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        activityIndicator.stopAnimating()
        continueButton.isHidden = false
        for (field, _) in errors {
            if let field = field as? UnderlinedTextField {
                field.borderColor = UIColor.red
            }
        }
    }
}


// MARK: - SelectSetPresenterOutput

extension SelectSetViewController: SelectSetViewControllerInput {
    
    func displayOptions(options: [String]) {
        print(options.count)
        pickerOptions = options
        pickerView.reloadAllComponents()
    }
    
    func displayError(errorMessage: String) {
        activityIndicator.stopAnimating()
        continueButton.isHidden = false
        displayErrorModal(error: errorMessage)
    }
    
    func displayJoinSchoolCompletion() {
        print("join school complete")
        router.navigateToJoinSchoolCompletion()
    }
    
}

extension SelectSetViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == facultyTextField {
            router.navigateToSelectDetailsScene(dataType: .Faculty, data: output.school.faculties)
        }
        else if textField == departmentTextField {
            router.navigateToSelectDetailsScene(dataType: .Department, data: output.school.departments)
        }
        else {
            return true
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Editing!!!")
        activeField = textField as? UnderlinedTextField
        if textField == facultyTextField {
            output.updatePickerOptions(optionType: .faculty)
        }
        if  textField == departmentTextField {
            output.updatePickerOptions(optionType: .department)
        }
        if textField == setTextField {
            output.updatePickerOptions(optionType: .set)
        }
    }
}

extension SelectSetViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let activeField = activeField {
            activeField.text = pickerOptions[row]
            output.selectedSet = Int(pickerOptions[row])
        }
    }
}

enum OptionType {
    case faculty
    case department
    case set
}
