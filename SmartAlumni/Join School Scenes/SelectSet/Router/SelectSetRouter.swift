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
    
    func navigateToJoinSchoolCompletion() {
        let joinSchoolStoryboard = UIStoryboard(name: "JoinSchool", bundle: nil)
        if let joinSetCompletionVC = joinSchoolStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.JoinSetCompletionScene) as? JoinSetCompletionViewController {
            viewController?.navigationController?.pushViewController(joinSetCompletionVC, animated: true)
        }
    }
}
