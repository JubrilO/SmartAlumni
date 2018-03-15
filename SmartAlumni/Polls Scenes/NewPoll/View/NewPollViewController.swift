//
//  NewPollViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 11/2/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import SwiftValidator
import SkyFloatingLabelTextField

protocol NewPollViewControllerInput: NewPollPresenterOutput {
    
}

protocol NewPollViewControllerOutput {
    
    func displayError()
    func createPoll(title: String, question: String, options: [Option])
    func fetchPollVisibiltyOptions()
    var targetSchool: School? {get set}
    var targetFaculties: [Faculty] {get set}
    var targetDepartments: [Department] {get set}
    var targetSets: [String] {get set}
    var timeInterval: Duration {get set}
}

final class NewPollViewController: UIViewController {
    
    var output: NewPollViewControllerOutput!
    var router: NewPollRouterProtocol!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollAreaHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var timeIntervalPicker: TimeIntervalPicker!
    @IBOutlet weak var visibilityTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var optionTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var titleTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var timePickerHeightContraint: NSLayoutConstraint!
    
    var days = [String]()
    var hours = [String]()
    var minutes = [String]()
    var optionCount = 2
    
    var day = ""
    var hour = ""
    var min = ""
    
    let validator = Validator()
    
    // MARK: - Initializers
    
    init(configurator: NewPollConfigurator = NewPollConfigurator.sharedInstance) {
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Configurator
    
    private func configure(configurator: NewPollConfigurator = NewPollConfigurator.sharedInstance) {
        configurator.configure(viewController: self)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeIntervalLabel.text = ""
        optionTableView.tableFooterView = UIView()
        populatePicker()
        setupFields()
        setupTimeIntervalPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFields()
        output.fetchPollVisibiltyOptions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupScrollableArea()
    }
    
    @IBAction func onTapGestureReconized(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        if timeIntervalPicker.isHidden {
            showTimeIntervalPicker()
        }
        else {
           hideTimeIntervalPicker()
        }
    }
    
    @IBAction func onNextButtonTouch(_ sender: UIBarButtonItem) {
        validator.validate(self)
        diplayActivityIndicator()
    }
    
    @IBAction func onBackButtonTouch(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Load data
    
    func showTimeIntervalPicker() {
        self.view.layoutIfNeeded()
        timeIntervalPicker.isHidden = false
        scrollAreaHeightConstraint.constant += timeIntervalPicker.bounds.height
        view.layoutIfNeeded()
        self.timeIntervalPicker.transform = CGAffineTransform(translationX: 0, y: -70)
        timeIntervalPicker.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.timeIntervalPicker.alpha = 1
            self.timeIntervalPicker.transform = CGAffineTransform(translationX: 0, y: 0)
            self.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            
        }, completion: {_ in
            self.scrollView.scrollRectToVisible(self.timeIntervalPicker.frame, animated: true)
            self.view.layoutIfNeeded()
        })
    }
    
    func hideTimeIntervalPicker() {
        scrollView.scrollRectToVisible(titleTextField.convert(titleTextField.bounds, to: scrollView), animated: true)
        UIView.animate(withDuration: 0.2, animations: {self.timeIntervalPicker.alpha = 0}, completion: nil)
        UIView.animate(withDuration: 0.3, animations:{
            self.view.layoutIfNeeded()
            self.timeIntervalPicker.transform = CGAffineTransform(translationX: 0, y: -150)
            self.arrowImageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        }, completion: {
            _ in
            self.scrollAreaHeightConstraint.constant -= self.timeIntervalPicker.bounds.height
            self.view.layoutIfNeeded()
            self.timeIntervalPicker.isHidden = true
        })
    }
    
    func setupScrollableArea() {
        let navBarHeight = (self.navigationController?.navigationBar.intrinsicContentSize.height)!
            + UIApplication.shared.statusBarFrame.height
        scrollAreaHeightConstraint.constant = self.view.bounds.height - navBarHeight
        view.layoutIfNeeded()
    }
    
    func diplayActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.color = UIColor.black
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
    }
    
    func hideActivityIndicator() {
        let nextBarButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(onNextButtonTouch(_:)))
        nextBarButton.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = nextBarButton
    }
    
    func setupTimeIntervalPicker() {
        timeIntervalPicker.delegate = self
        timeIntervalPicker.dataSource = self
        let hourLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 44, height: 18))
        hourLabel.text = "Hours"
        hourLabel.font = UIFont.boldSystemFont(ofSize: 12)
        hourLabel.textColor = UIColor.gray
        let minuteLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 18))
        minuteLabel.text = "Min"
        minuteLabel.font = UIFont.boldSystemFont(ofSize: 12)
        minuteLabel.textColor = UIColor.gray
        let dayLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 36, height: 18))
        dayLabel.text = "Days"
        dayLabel.font = UIFont.boldSystemFont(ofSize: 12)
        dayLabel.textColor = UIColor.gray
        let labels = [0 : dayLabel, 1 : hourLabel, 2 : minuteLabel]
        timeIntervalPicker.setPickerLabels(labels: labels, containedView: view)
        timeIntervalPicker.isHidden = true
        arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    func setupFields() {
        titleTextField.titleFormatter = { (text:String) -> String in return text }
        questionTextField.titleFormatter = { (text:String) -> String in return text }
        visibilityTextField.titleFormatter = { (text:String) -> String in return text }
        
       setupTextFieldValidation()
        
        visibilityTextField.inputView = nil
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(routeToPollVisibilityScene))
        visibilityTextField.addGestureRecognizer(tapGesture)
        visibilityTextField.delegate = self
    }
    
    func setupTextFieldValidation() {
        validator.registerField(titleTextField, rules: [RequiredRule(), MaxLengthRule(length: 20)])
        validator.registerField(questionTextField, rules: [RequiredRule(), MaxLengthRule(length: 20)])
        validator.registerField(visibilityTextField, rules: [RequiredRule()])
        
        let option1Cell = optionTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! OptionCell
        let option2Cell = optionTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! OptionCell
        
        validator.registerField(option1Cell.optionField, rules: [RequiredRule(), MaxLengthRule(length: 25)])
        validator.registerField(option2Cell.optionField, rules: [RequiredRule(), MaxLengthRule(length: 25)])
    }
    
    @objc func routeToPollVisibilityScene() {
        router.navigateToPollVisibilityScene(school: output.targetSchool, departments: output.targetDepartments, faculties: output.targetFaculties, sets: output.targetSets )
    }
    
    func updateIntervalLabel(string: String, type: TimeIntervalType) {
        switch type {
        case .day:
            timeIntervalLabel.text = "\(string.dayValue()) \(hour.hourValue()) \(min.minutesValue())"
            output.timeInterval.day = Int(string)
            output.timeInterval.hour = Int(hour)
            output.timeInterval.minute = Int(min)
        case .hour:
            timeIntervalLabel.text = "\(day.dayValue()) \(string.hourValue()) \(min.minutesValue())"
            output.timeInterval.day = Int(day)
            output.timeInterval.hour = Int(string)
            output.timeInterval.minute = Int(min)
        case .minute:
            timeIntervalLabel.text = "\(day.dayValue()) \(hour.hourValue()) \(string.minutesValue())"
            output.timeInterval.day = Int(day)
            output.timeInterval.hour = Int(hour)
            output.timeInterval.minute = Int(string)
        }
        
    }
    
    func populatePicker() {
        for i in 0 ... 10 {
            days.append(String(i))
        }
        
        for i in 0 ... 23{
            hours.append(String(i))
        }
        
        for i in 0 ... 59 {
            minutes.append(String(i))
        }
    }
    
    @objc func addOption() {
        print("Add option action!!")
        if optionCount < 4 {
            optionCount = optionCount + 1
            print(optionCount)
            scrollAreaHeightConstraint.constant = scrollAreaHeightConstraint.constant + 64
            view.layoutIfNeeded()
            tableViewHeightConstraint.constant = CGFloat(64 * optionCount)
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            optionTableView.beginUpdates()
            optionTableView.insertRows(at: [IndexPath.init(row: optionCount - 1, section: 0)], with: .top)
            optionTableView.endUpdates()
            hideAddButtons()
        }
    }
    
    func isTimeIntervalValid() -> Bool {
        if timeIntervalLabel.text == "" {
            return false
        }
        else {
            return true
        }
    }
    
    func hideAddButtons() {
        for cell in optionTableView.visibleCells as! [OptionCell]{
            if cell != optionTableView.visibleCells.last {
                cell.addOptionButton.isHidden = true
            }
        }
    }
    
    func getOptions() -> [Option] {
        var options = [Option]()
        guard let optionCells = optionTableView.visibleCells as? [OptionCell] else {return options}
        for optionCell in optionCells {
            if optionCell.optionField.text != "" {
                options.append(Option(text: optionCell.optionField.text!))
            }
        }
        return options
    }
}

// MARK: - NewPollPresenterOutput

class Option {
    let text: String
    init(text: String) {
        self.text = text
    }
}

extension NewPollViewController: ValidationDelegate {
    
    func validationSuccessful() {
        if isTimeIntervalValid() {
            let title = titleTextField.text!
            let question = questionTextField.text!
            let options = getOptions()
            output.createPoll(title: title, question: question, options: options)
        }
        else {
            hideActivityIndicator()
            displayErrorModal(error: "Invalid time interval")
        }
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        hideActivityIndicator()
        for (field, error) in errors {
            if let field = field as? SkyFloatingLabelTextField {
                field.errorMessage = error.errorMessage
            }
        }
    }
}

extension NewPollViewController: NewPollViewControllerInput {
    
    
    // MARK: - Display logic
    
    func displayPollVisibilityOptions(options: String) {
        visibilityTextField.text = options
    }
    
    func diplayPollCompletionScene() {
        hideActivityIndicator()
        router.navigateToPollCompletionScene()
    }
    
    func dispayError(errorMessage: String?) {
        displayErrorModal(error: errorMessage)
    }
}

extension NewPollViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return days[row]
        case 1:
            return hours[row]
        case 2:
            return minutes[row]
        default:
            return nil 
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        switch component {
        case 0:
            day = days[row]
            updateIntervalLabel(string: day, type: .day)
        case 1:
            hour = hours[row]
            updateIntervalLabel(string: hour, type: .hour)
        case 2:
            min = minutes[row]
            updateIntervalLabel(string: min, type: .minute)
        default:
            break
        }
    }
}

extension NewPollViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        switch component {
        case 0:
            return 11
        case 1:
            return 24
        case 2:
            return 60
        default:
            return 0
        }
    }
    
}

extension NewPollViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell") as! OptionCell
        cell.optionField.placeholder = "Option " + String(1 + indexPath.row)
        cell.optionField.titleFormatter = { (text:String) -> String in return text }
        cell.addOptionButton.isHidden = true
        cell.addOptionButton.addTarget(self, action: #selector(addOption), for: .touchUpInside)
        if indexPath.row == (optionCount-1) {
            cell.addOptionButton.isHidden = false
        }
        return cell
    }
}

extension NewPollViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == visibilityTextField {
            return false 
        }
        else {
            return true
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == visibilityTextField {
            return false
        }
        return true
    }
    
    
}

enum TimeIntervalType {
    case day
    case hour
    case minute
}


