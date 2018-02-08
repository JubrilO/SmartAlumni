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
    var targetSchool: School {get set}
    var targetDeparments: [Department] {get set}
    var targetFaculties: [Faculty] {get set}
    var targetSets: [String] {get set}
    func fetchSchools()
    func fetchFaculties(schoolIndex: Int)
    func fetchDepartments()
    func fetchSets()
}

final class PollVisibilityViewController: UIViewController {

    var output: PollVisibilityViewControllerOutput!
    var router: PollVisibilityRouterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    let pickerView = UIPickerView()
    var pickerData = [String]()
    var selectedIndex = 0

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

    // MARK: - Load data
    
    func fetchSchools() {
        output.fetchSchools()
    }
    
    func setupNavBar() {
        title = "Visibility"
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(saveVisibilitySettings))
        doneBarButton.tintColor = UIColor.black
        navigationItem.setRightBarButton(doneBarButton, animated: false)
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func saveVisibilitySettings() {
        print("saving visibility settings")
    }
    
}


// MARK: - PollVisibilityPresenterOutput

extension PollVisibilityViewController: PollVisibilityViewControllerInput {

    // MARK: - Display logic

    func displaySchools() {
        pickerView.reloadAllComponents()
    }
    
    func displayDepartments() {
        pickerView.reloadAllComponents()
    }
    
    func displayFaculties() {
        pickerView.reloadAllComponents()
    }
    
}

extension PollVisibilityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.VisibilityCell) as! VisibilityCell
        cell.titleTextField.delegate = self
        cell.titleTextField.inputView = pickerView
        
        switch indexPath.row {
        case 0:
            cell.titleTextField.placeholder = "Target School"
            cell.titleTextField.tag = 0
        case 1:
            cell.titleTextField.placeholder = "Faculty"
            cell.titleTextField.tag = 1
        case 2:
            cell.titleTextField.placeholder = "Department"
            cell.titleTextField.tag = 2
        case 3:
            cell.titleTextField.placeholder = "Set"
            cell.titleTextField.tag = 3
        default:
            return cell
        }
        
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            router.navigateToVisibilityOptionScene(dataType: .School)
        case 1:
            router.navigateToVisibilityOptionScene(dataType: .Faculty)
        case 2:
            router.navigateToVisibilityOptionScene(dataType: .Department)
        case 3:
            router.navigateToVisibilityOptionScene(dataType: .Set)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        pickerData = [String]()
    }
}

