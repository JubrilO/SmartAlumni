//
//  PollVisibilityRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 11/23/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol PollVisibilityRouterProtocol {

    weak var viewController: PollVisibilityViewController? { get }

    func navigateToVisibilityOptionScene(dataType: DataType)
    func navigateToNewPollScene(school: School, faculties: [Faculty], departments: [Department], sets: [String])
}

final class PollVisibilityRouter {

    weak var viewController: PollVisibilityViewController?


    // MARK: - Initializers

    init(viewController: PollVisibilityViewController?) {

        self.viewController = viewController
    }
}


// MARK: - PollVisibilityRouterProtocol

extension PollVisibilityRouter: PollVisibilityRouterProtocol {
    
    func navigateToVisibilityOptionScene(dataType: DataType) {
        let pollsStoryboard = UIStoryboard(name: Constants.StoryboardNames.Polls, bundle: nil)
        let visibilityOptionScene = pollsStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.VisibilityOptionScene) as! VisibilityOptionViewController
        visibilityOptionScene.output.dataType = dataType
        
        switch dataType {
        case .Faculty:
            if let faculties = viewController?.output.targetSchool?.faculties {
                visibilityOptionScene.output.faculties = faculties
            }
        case .Department:
            if let departments = viewController?.output.targetSchool?.departments {
                visibilityOptionScene.output.departments = departments
            }
        case .Set:
            if let sets = viewController?.output.targetSchool?.sets {
                visibilityOptionScene.output.sets = sets
            }
        default:
            break
        }
        viewController?.navigationController?.pushViewController(visibilityOptionScene, animated: true)
    }
    
    func navigateToNewPollScene(school: School, faculties: [Faculty], departments: [Department], sets: [String]) {
        if let previousVC = viewController?.previousViewController as? NewPollViewController {
            previousVC.output.targetSchool = school
            previousVC.output.targetFaculties = faculties
            previousVC.output.targetDepartments = departments
            previousVC.output.targetSets = sets
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
