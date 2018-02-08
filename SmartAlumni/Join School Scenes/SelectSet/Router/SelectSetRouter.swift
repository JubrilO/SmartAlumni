//
//  SelectSetRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 8/29/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol SelectSetRouterProtocol {

    weak var viewController: SelectSetViewController? { get }

    func navigateToJoinSchoolCompletion()
    func navigateToSelectDetailsScene(dataType: DataType, data: [Any])
}

final class SelectSetRouter {

    weak var viewController: SelectSetViewController?


    // MARK: - Initializers

    init(viewController: SelectSetViewController?) {

        self.viewController = viewController
    }
}


// MARK: - SelectSetRouterProtocol

extension SelectSetRouter: SelectSetRouterProtocol {


    // MARK: - Navigation
    
    func navigateToSelectDetailsScene(dataType: DataType, data: [Any]) {
        let joinSchoolStoryboard = UIStoryboard(name: "JoinSchool", bundle: nil)
        if let selectDetailsVC = joinSchoolStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.SelectFacultyScene) as? SelectFacultyViewController   {
            selectDetailsVC.dataType = dataType
            switch dataType {
            case .Department:
                selectDetailsVC.departments = data as! [Department]
                viewController?.navigationController?.pushViewController(selectDetailsVC, animated: true)
            case .Faculty:
                selectDetailsVC.faculties = data as! [Faculty]
                viewController?.navigationController?.pushViewController(selectDetailsVC, animated: true)
            default:
                break
            }
        
        }
    }
    
    func navigateToJoinSchoolCompletion() {
        let joinSchoolStoryboard = UIStoryboard(name: "JoinSchool", bundle: nil)
        if let joinSetCompletionVC = joinSchoolStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.JoinSetCompletionScene) as? JoinSetCompletionViewController {
            joinSetCompletionVC.school = viewController?.output.school
            joinSetCompletionVC.set = viewController?.output.selectedSet
            viewController?.navigationController?.pushViewController(joinSetCompletionVC, animated: true)
        }
    }
}
