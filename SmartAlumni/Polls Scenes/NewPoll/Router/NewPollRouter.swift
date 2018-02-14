//
//  NewPollRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 11/2/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol NewPollRouterProtocol {
    
    weak var viewController: NewPollViewController? { get }
    
    func navigateToPollVisibilityScene(school: School?, departments: [Department], faculties: [Faculty], sets: [String])
    func navigateToPollCompletionScene()
    
}

final class NewPollRouter {
    
    weak var viewController: NewPollViewController?
    
    
    // MARK: - Initializers
    
    init(viewController: NewPollViewController?) {
        
        self.viewController = viewController
    }
}


// MARK: - NewPollRouterProtocol

extension NewPollRouter: NewPollRouterProtocol {
    
    
    // MARK: - Navigation
    
    func navigateToPollVisibilityScene(school: School?, departments: [Department], faculties: [Faculty], sets: [String]) {
        
        if  let visibilityVC = UIStoryboard(name: Constants.StoryboardNames.Polls, bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.PollVisibilityScene) as? PollVisibilityViewController {
            print("pushing vc")
            visibilityVC.output.targetSchool = school
            visibilityVC.output.targetFaculties = faculties
            visibilityVC.output.targetDeparments = departments
            visibilityVC.output.targetSets = sets
            viewController?.navigationController?.pushViewController(visibilityVC, animated: true)
        }
    }
    
    func navigateToPollCompletionScene() {
        if let pollCompletionVC = viewController?.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.PollCompletionScene) as? PollCompletionViewController {
            viewController?.navigationController?.pushViewController(pollCompletionVC, animated: true)
        }
    }
}
