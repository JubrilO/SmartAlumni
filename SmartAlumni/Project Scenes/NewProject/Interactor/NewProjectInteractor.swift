//
//  NewProjectInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 2/20/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol NewProjectInteractorInput: NewProjectViewControllerOutput {
    
}

protocol NewProjectInteractorOutput {
    
    func presentSomething()
    func presentError(string: String?)
    func presentSuccessScreen()
}

final class NewProjectInteractor: NewProjectViewControllerOutput {
    
    
    let output: NewProjectInteractorOutput
    let worker: NewProjectWorker
    
    var timeInterval = Duration()
    var accountDetails: AccountDetails?
    var targetSchool: School?
    var targetDepartments = [Department]()
    var targetFaculties = [Faculty]()
    var targetSets = [String]()

    
    
    // MARK: - Initializers
    
    init(output: NewProjectInteractorOutput, worker: NewProjectWorker = NewProjectWorker()) {
        
        self.output = output
        self.worker = worker
    }
    
    
    // MARK: - NewProjectInteractorInput
    
    
    
    // MARK: - Business logic
    
    
    func createProject(title: String, desc: String, amount: String, startDate: String, endDate: String, milestones: [Milestone], image: UIImage?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let startDate = dateFormatter.date(from: startDate)!
        let endDate = dateFormatter.date(from: endDate)!
        
        guard let accountDetails = accountDetails else {output.presentError(string: "Enter account details associated with this project"); return}
        
        ProjectAPI.sharedManager.createProject(title: title, desc: desc, amount: amount, startDate: startDate, endDate: endDate, milestones: milestones, visibility: generatePollVisibiltyDict(), account: accountDetails, image: image) {
            project, error in
            guard error == nil else {self.output.presentError(string: error?.localizedDescription); return}
            if let _ = project {
                self.output.presentSuccessScreen()
            }
        }
        
    }
    
    func generatePollVisibiltyDict() -> [String : Any]{
        var visibilityDict = [String:Any]()
        
        guard let schoolID = targetSchool?.id else {
            return visibilityDict
        }
        
        let sets = targetSets
        let facultyIDs = targetFaculties.map{$0.id}
        let deparmentIDs = targetDepartments.map{$0.id}
        
        visibilityDict =  [
            "school_set" : sets,
            "school" : schoolID,
            "faculty" : facultyIDs,
            "department" : deparmentIDs
        ]
        
        return visibilityDict
    }

}
