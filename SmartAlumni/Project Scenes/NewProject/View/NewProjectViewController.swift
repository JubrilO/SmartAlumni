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
    
    func doSomething()
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
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var durationView: UIView!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var timeIntervalPicker: UIPickerView!
    @IBOutlet weak var milestoneTableView: UITableView!
    @IBOutlet weak var tagsTextFeld: SkyFloatingLabelTextField!
    @IBOutlet weak var projectAccount: UILabel!
    @IBOutlet weak var projectVisibility: UILabel!
    @IBOutlet weak var goalTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var descriptionTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var titleTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
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
        nextButton.isEnabled = false
        populatePicker()
        setupTextFields()
        setupTimeIntervalPicker()
    }
    
    @IBAction func onNextButtonTap(_ sender: UIBarButtonItem) {
        validator.validate(self)
        diplayActivityIndicator()
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
        
    }
    
    @IBAction func onDurationCellTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        if timeIntervalPicker.isHidden {
            showTimeIntervalPicker()
        }
        else {
            hideTimeIntervalPicker()
        }
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
    
    func validationSuccessful() {
        
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        
    }
    
    func diplayActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.color = UIColor.black
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
    }
    
    func hideActivityIndicator() {
        let nextBarButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(onNextButtonTap(_:)))
        nextBarButton.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = nextBarButton
    }
    
    func setupTextFields() {
        titleTextField.titleFormatter = { (text:String) -> String in return text }
        descriptionTextField.titleFormatter = { (text:String) -> String in return text }
        goalTextField.titleFormatter = { (text:String) -> String in return text }
        tagsTextFeld.titleFormatter = { (text:String) -> String in return text }
    }
    
    func setupTextFieldValidation() {
        validator.registerField(titleTextField, rules: [RequiredRule(), MaxLengthRule(length: 20)])
        validator.registerField(descriptionTextField, rules: [RequiredRule(), MaxLengthRule(length: 25)])
        validator.registerField(goalTextField, rules: [RequiredRule(), FloatRule(message: "Please enter a valid amount. (Without commas or currency)")])
    }
    
    func showTimeIntervalPicker() {
        self.view.layoutIfNeeded()
        timeIntervalPicker.isHidden = false
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
            self.view.layoutIfNeeded()
            self.timeIntervalPicker.isHidden = true
        })
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
        if milestoneCount < 4 {
            milestoneCount = milestoneCount + 1
            view.layoutIfNeeded()
            tableViewHeightConstraint.constant = CGFloat(64 * milestoneCount)
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            milestoneTableView.beginUpdates()
            milestoneTableView.insertRows(at: [IndexPath.init(row: milestoneCount - 1, section: 0)], with: .top)
            milestoneTableView.endUpdates()
            hideAddButtons()
        }
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
    
    
    // MARK: - Display logic
    
    func displaySomething(viewModel: NewProjectViewModel) {
        
        // TODO: Update UI
    }
}

extension NewProjectViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

extension NewProjectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return milestoneCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell") as! OptionCell
        cell.optionField.placeholder = "Milestone " + String(1 + indexPath.row)
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
