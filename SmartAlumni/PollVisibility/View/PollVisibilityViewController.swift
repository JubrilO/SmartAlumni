//
//  PollVisibilityViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 11/23/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol PollVisibilityViewControllerInput: PollVisibilityPresenterOutput {
    
}

protocol PollVisibilityViewControllerOutput {
    
    var schools: [School] {get set}
    var departments: [Department] {get set}
    var faculties: [Faculty] {get set}
    var pickerData: [String] {get set}
    var targetSchool: School? {get set}
    var targetDeparments: [Department] {get set}
    var targetFaculties: [Faculty] {get set}
    var targetSets: [String] {get set}
    func fetchSchools()
    func fetchFaculties(schoolIndex: Int)
    func fetchDepartments()
    func fetchSets()
    func getPollVisiblityData()
    func saveVisibilityOptions()
}

final class PollVisibilityViewController: UIViewController {
    
    var output: PollVisibilityViewControllerOutput!
    var router: PollVisibilityRouterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    let pickerView = UIPickerView()
    var pickerData = [String]()
    var selectedIndex = 0
    var doneBarButton = UIBarButtonItem()
    var textFieldType = ["Target School", "Faculty", "Department", "Set"]
    
    init(configurator: PollVisibilityConfigurator = PollVisibilityConfigurator.sharedInstance) {
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Configurator
    
    private func configure(configurator: PollVisibilityConfigurator = PollVisibilityConfigurator.sharedInstance) {
        configurator.configure(viewController: self)
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        pickerView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.getPollVisiblityData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTextfields()
    }
    
    // MARK: - Load data
    
    func fetchSchools() {
        output.fetchSchools()
    }
    
    func setupTextfields() {
        if output.targetSchool?.category == SchoolCategory.Secondary.rawValue || output.targetSchool?.category == SchoolCategory.Primary.rawValue {
            textFieldType.remove(at: 1)
            textFieldType.remove(at: 2)
            let deparmentIndexPath = IndexPath(row: 2, section: 0)
            let facultyIndexPath = IndexPath(row: 1, section: 0)
            tableView.deleteRows(at: [facultyIndexPath, deparmentIndexPath], with: .automatic)
        }
        else {
            textFieldType = ["Target School", "Faculty", "Department", "Set"]
            tableView.reloadData()
        }
    }
    
    func setupNavBar() {
        title = "Visibility"
        doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(saveVisibilitySettings))
        doneBarButton.tintColor = UIColor.black
        navigationItem.setRightBarButton(doneBarButton, animated: false)
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func saveVisibilitySettings() {
        print("saving visibility settings")
        if let targetSchool = output.targetSchool {
            router.navigateToNewPollScene(school: targetSchool, faculties: output.targetFaculties, departments: output.targetDeparments, sets: output.targetSets)
        }
    }
}


// MARK: - PollVisibilityPresenterOutput

extension PollVisibilityViewController: PollVisibilityViewControllerInput {
    
    // MARK: - Display logic
    func displayTargetSchool(school: String) {
        let schoolCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! VisibilityCell
        schoolCell.titleTextField.text = school
        doneBarButton.isEnabled = true
    }
    
    func displayTargetDepartments(departments: String) {
        if let index = textFieldType.index(of: "Department") {
            let departmentCell = tableView.cellForRow(at: IndexPath(row: Int(index), section: 0)) as! VisibilityCell
            departmentCell.titleTextField.text = departments
        }
    }
    
    func displayTargetFaculties(faculties: String) {
        if let index = textFieldType.index(of: "Faculty"){
            let facultyCell = tableView.cellForRow(at: IndexPath(row: Int(index), section: 0)) as! VisibilityCell
            facultyCell.titleTextField.text = faculties
        }
    }
    
    func displayTargetSets(sets: String) {
        if let index = textFieldType.index(of: "Set"){
            let setCell = tableView.cellForRow(at: IndexPath(row: Int(index), section: 0)) as! VisibilityCell
            setCell.titleTextField.text = sets
        }
    }
}

extension PollVisibilityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textFieldType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.VisibilityCell) as! VisibilityCell
        cell.titleTextField.delegate = self
        cell.titleTextField.inputView = pickerView
        cell.titleTextField.placeholder = textFieldType[indexPath.row]
        cell.titleTextField.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}

extension PollVisibilityViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return output.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentFirstResponder = UIResponder.first as! UITextField
        currentFirstResponder.text = output.pickerData[row]
    }
}

extension PollVisibilityViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            router.navigateToVisibilityOptionScene(dataType: .School)
        case 1:
            guard output.targetSchool != nil else {displayErrorModal(error: "Select a target school first"); return false}
            router.navigateToVisibilityOptionScene(dataType: .Faculty)
        case 2:
            guard output.targetSchool != nil else {displayErrorModal(error: "Select a target school first"); return false}
            router.navigateToVisibilityOptionScene(dataType: .Department)
        case 3:
            guard output.targetSchool != nil else {displayErrorModal(error: "Select a target school first"); return false}
            router.navigateToVisibilityOptionScene(dataType: .Set)
        default:
            break
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        pickerData = [String]()
    }
}

