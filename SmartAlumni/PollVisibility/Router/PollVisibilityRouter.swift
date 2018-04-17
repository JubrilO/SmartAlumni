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
                visibilityOptionScene.output.faculties = faculties.sorted{faculty1, faculty2 in return faculty1.name < faculty2.name}
                visibilityOptionScene.output.targetFaculties = viewController?.output.targetFaculties
                
            }
        case .Department:
            if let departments = viewController?.output.targetSchool?.departments {
                visibilityOptionScene.output.departments = departments.sorted{ dept1, dept2 in return dept1.name < dept2.name}
                visibilityOptionScene.output.targetDepartments = viewController?.output.targetDeparments
            }
        case .Set:
            if let sets = viewController?.output.targetSchool?.sets {
                visibilityOptionScene.output.sets = sets.sorted{ set1, set2 in return set1 < set2}
                visibilityOptionScene.output.targetSets = viewController?.output.targetSets
            }
        case .School:
            visibilityOptionScene.output.targetSchool = viewController?.output.targetSchool
        }
        viewController?.navigationController?.pushViewController(visibilityOptionScene, animated: true)
    }
    
    func navigateToNewPollScene(school: School, faculties: [Faculty], departments: [Department], sets: [String]) {
        if let previousVC = viewController?.previousViewController as? NewPollViewController {
            previousVC.output.targetSchool = school
            previousVC.output.targetFaculties = faculties.isEmpty ? school.faculties : faculties
            previousVC.output.targetDepartments = departments.isEmpty ? school.departments : departments
            previousVC.output.targetSets = sets.isEmpty ? school.sets : sets
            viewController?.navigationController?.popViewController(animated: true)
        }
        else if let previousVC = viewController?.previousViewController as? NewProjectViewController {
            previousVC.output.targetSchool = school
            previousVC.output.targetFaculties = faculties.isEmpty ? school.faculties : faculties
            previousVC.output.targetDepartments = departments.isEmpty ? school.departments : departments
            previousVC.output.targetSets = sets.isEmpty ? school.sets : sets
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
