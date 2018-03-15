//
//  SelectCategoryVC.swift
//  SmartAlumni
//
//  Created by Jubril on 2/2/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

class SelectSchoolCategoryVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let schoolCategories = ["University", "Secondary School", "Primary School", "College of Education"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "School Category"
        tableView.tableFooterView = UIView()
        showNavigationBar()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: #selector(popViewController))
        navigationItem.backBarButtonItem = leftBarButtonItem
        navigationItem.backBarButtonItem?.tintColor = Constants.Colors.softBlue
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func navigateToSelectSchoolScene(category: SchoolCategory) {
        let joinSchoolStoryboard = UIStoryboard(name: Constants.StoryboardNames.JoinSchool, bundle: nil)
        if let selectSchoolVC = joinSchoolStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.SelectSchoolScene) as? SelectSchoolViewController {
            selectSchoolVC.output.schoolCategory = category
            navigationController?.pushViewController(selectSchoolVC, animated: true)
        }
    }
}

extension SelectSchoolCategoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let titleText = schoolCategories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.SelectSchoolCell, for: indexPath) as! SelectSchoolCell
        cell.schoolLabel.text = titleText
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolCategories.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
           
            print("Case 0: Tertiary")
            navigateToSelectSchoolScene(category: .Tertiary)
        case 1:
            navigateToSelectSchoolScene(category: .Secondary)
        case 2:
            navigateToSelectSchoolScene(category: .Primary)
        default:
            break
        }
    }
}

enum SchoolCategory: String {
    case Tertiary
    case Secondary
    case Primary
}
