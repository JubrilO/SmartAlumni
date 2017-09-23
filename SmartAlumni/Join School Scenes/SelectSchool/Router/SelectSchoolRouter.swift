//
//  SelectSchoolRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 8/24/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol SelectSchoolRouterProtocol {

    weak var viewController: SelectSchoolViewController? { get }

    func navigateToSelectSetScene(schoolIndex: Int)
}

final class SelectSchoolRouter {

    weak var viewController: SelectSchoolViewController?


    // MARK: - Initializers

    init(viewController: SelectSchoolViewController?) {

        self.viewController = viewController
    }
}


// MARK: - SelectSchoolRouterProtocol

extension SelectSchoolRouter: SelectSchoolRouterProtocol {


    // MARK: - Navigation

    func navigateToSelectSetScene(schoolIndex: Int) {
        if let school = viewController?.output.schools[schoolIndex] {
        
        if let selectSetVC = viewController?.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.SelectSetScene) as? SelectSetViewController {
            selectSetVC.output.school = school
        viewController?.navigationController?.pushViewController(selectSetVC, animated: true)
        }
    }
    }
}
