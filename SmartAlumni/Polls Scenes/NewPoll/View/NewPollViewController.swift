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
    func createPoll(title: String, question: String, options: [Option], timeInterval: String, visibility: String)
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
    
    let visiblityArray = ["Everyone", "Unilag", "FUTA"]
    let validator = Validator()
    let visiblityPickerView = UIPickerView()
    
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
        validator.registerField(titleTextField, rules: [RequiredRule(), MaxLengthRule(length: 20)])
        validator.registerField(questionTextField, rules: [RequiredRule(), MaxLengthRule(length: 20)])
        visiblityPickerView.delegate = self
        visibilityTextField.inputView = nil
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(routeToVisibilityScene))
        visibilityTextField.addGestureRecognizer(tapGesture)
        visibilityTextField.delegate = self
    }
    
    func routeToVisibilityScene() {
        router.navigateToVisibilityScene()
    }
    
    func updateIntervalLabel(string: String, type: TimeIntervalType) {
        switch type {
        case .day:
            timeIntervalLabel.text = "\(string.dayValue()) \(hour.hourValue()) \(min.minutesValue())"
        case .hour:
            timeIntervalLabel.text = "\(day.dayValue()) \(string.hourValue()) \(min.minutesValue())"
        case .minute:
            timeIntervalLabel.text = "\(day.dayValue()) \(hour.hourValue()) \(string.minutesValue())"
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
    
    func addOption() {
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
            let visibility = visibilityTextField.text!
            let timeInterval = timeIntervalLabel.text!
            output.createPoll(title: title, question: question, options: options, timeInterval: timeInterval, visibility: visibility)
        }
        else {
            output.displayError()
        }
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        output.displayError()
    }
}

extension NewPollViewController: NewPollViewControllerInput {
    
    
    // MARK: - Display logic
    
    func displaySomething(viewModel: NewPollViewModel) {
        
        // TODO: Update UI
    }
}

extension NewPollViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == visiblityPickerView {
            return visiblityArray[row]
        }
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
        if pickerView == visiblityPickerView {
            visibilityTextField.text = visiblityArray[row]
        }
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
        if pickerView == visiblityPickerView {
            return 1
        }
        else {
            return 3
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == visiblityPickerView {
            return visiblityArray.count
        }
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
        
        switch indexPath.row {
        case 0:
            validator.registerField(cell.optionField, rules: [RequiredRule()])
        case 1:
            validator.registerField(cell.optionField, rules: [RequiredRule()])
        default:
            break
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

extension String {
    func dayValue() -> String {
        if self == "0" || self == "" {
            return ""
        }
        else if self == "1" {
            return "\(self) day"
        }
        else {
            return "\(self) days"
        }
    }
    
    func hourValue() -> String {
        if self == "0" || self == ""{
            return ""
        }
        else {
            return "\(self) hr"
        }
    }
    
    func minutesValue() -> String {
        if self == "0" || self == ""{
            return ""
        }
        else {
            return "\(self) min"
        }
    }
    
}

