//
//  SelectFacultyViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 2/7/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import UIKit

class SelectFacultyViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var departments = [Department]()
    var faculties = [Faculty]()
    var dataStore = [Any]()
    var dataType = DataType.Faculty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = dataType.rawValue
        switch dataType {
        case .Department:
            dataStore = departments
        case .Faculty:
            dataStore = faculties
        default:
            break
        }
        tableView.tableFooterView = nil
    }

    func updateSearchResults(searchTerm: String) {
        switch dataType {
        case .Department:
            dataStore = departments.filter{$0.name.contains(searchTerm)}
            tableView.reloadData()
        case .Faculty:
            dataStore = faculties.filter{$0.name.contains(searchTerm)}
            tableView.reloadData()
        default:
            break
        }
    }
    
}

extension SelectFacultyViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateSearchResults(searchTerm: searchText)
    }
}

extension SelectFacultyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.SelectSchoolCell) as! SelectSchoolCell
        cell.checkImageView.isHidden = true
        switch dataType {
        case .Department:
            let deparment = dataStore[indexPath.row] as! Department
            cell.schoolLabel.text = deparment.name
        case .Faculty:
            let faculty = dataStore[indexPath.row] as! Faculty
            cell.schoolLabel.text = faculty.name
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath) as! SelectSchoolCell
        deselectedCell.checkImageView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! SelectSchoolCell
        selectedCell.checkImageView.isHidden = false
        switch dataType {
        case .Department:
            let selectedDepartment = dataStore[indexPath.row] as! Department
            if let previousVC = previousViewController as? SelectSetViewController {
                previousVC.output.selectedDepartment = selectedDepartment
                delayWithSeconds(1){
                self.navigationController?.popViewController(animated: true)
                }
            }
        case .Faculty:
            let selectedFaculty = dataStore[indexPath.row] as! Faculty
            if let previousVC = previousViewController as? SelectSetViewController {
                previousVC.output.selectedFaculty = selectedFaculty
                delayWithSeconds(1) {
                self.navigationController?.popViewController(animated: true)
                }
            }
        default:
            break
        }
    }
}
