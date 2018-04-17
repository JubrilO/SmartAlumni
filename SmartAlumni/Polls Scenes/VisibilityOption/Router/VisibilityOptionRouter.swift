//
//  VisibilityOptionRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 11/28/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol VisibilityOptionRouterProtocol {
    
    weak var viewController: VisibilityOptionViewController? { get }
    
    func routeToNewPollScene(selectedRowIndex: Int, dataType: DataType)
     func routeToNewPollScene(selectedIndexes: [IndexPath], dataType: DataType)
}

final class VisibilityOptionRouter {
    
    weak var viewController: VisibilityOptionViewController?
    
    
    // MARK: - Initializers
    
    init(viewController: VisibilityOptionViewController?) {
        
        self.viewController = viewController
    }
}


// MARK: - VisibilityOptionRouterProtocol

extension VisibilityOptionRouter: VisibilityOptionRouterProtocol {
    
    
    // MARK: - Navigation
    
    func routeToNewPollScene(selectedRowIndex: Int, dataType: DataType) {
        switch dataType {
        case .School:
            if let selectedSchool = viewController?.output.schools[selectedRowIndex] {
                let pollVisibilityVC = viewController?.presentingViewController as! PollVisibilityViewController
                pollVisibilityVC.output.targetSchool = selectedSchool
            }
        default:
            return
        }
        viewController?.navigationController?.popViewController(animated: true)
        
    }
    
    func routeToNewPollScene(selectedIndexes: [IndexPath], dataType: DataType) {
        let pollVisibilityVC = viewController?.previousViewController as! PollVisibilityViewController
        switch dataType {
        case .School:
            if let selectedIndex = selectedIndexes.first {
                let school = viewController?.output.schools[selectedIndex.row]
                pollVisibilityVC.output.targetSchool = school
            }
        case .Faculty:
            var faculties = [Faculty]()
            for selectedIndex in selectedIndexes {
                if let faculty = viewController?.output.faculties[selectedIndex.row] {
                    faculties.append(faculty)
                }
            }
            pollVisibilityVC.output.targetFaculties = faculties
        case .Department:
            var deparments = [Department]()
            for selectedIndex in selectedIndexes {
                if let deparment = viewController?.output.departments[selectedIndex.row] {
                    deparments.append(deparment)
                }
            }
            pollVisibilityVC.output.targetDeparments = deparments
        case .Set:
            var sets = [String]()
            for selectedIndex in selectedIndexes {
                if let set = viewController?.output.sets[selectedIndex.row] {
                    sets.append(set)
                }
            }
            print("Sets: \(sets)")
            pollVisibilityVC.output.targetSets = sets
        }
       
        viewController?.navigationController?.popViewController(animated: true)
    }
}
