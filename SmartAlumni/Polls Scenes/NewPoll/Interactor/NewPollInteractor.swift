//
//  NewPollInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 11/2/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol NewPollInteractorInput: NewPollViewControllerOutput {
    
}

protocol NewPollInteractorOutput {
    
    func presentPollVisiblityOptions(string: String)
    func presentError(string: String?)
    func presentPollCreationCompleteScene()
    
}

final class NewPollInteractor: NewPollViewControllerOutput {
    
    let output: NewPollInteractorOutput
    let worker: NewPollWorker
    
    
    // MARK: - Initializers
    
    init(output: NewPollInteractorOutput, worker: NewPollWorker = NewPollWorker()) {
        
        self.output = output
        self.worker = worker
    }
    
    var targetSchool: School?
    var targetFaculties = [Faculty]()
    var targetDepartments = [Department]()
    var targetSets = [String]()
    var timeInterval: DateComponents?
    
    // MARK: - Business logic
    
    func displayError() {
        
    }
    
    func createPoll(title: String, question: String, options: [Option]) {
        let startDate = Date()
        let timeInterval = timeIntervalFromDateComponents()
        let endDate = startDate.addingTimeInterval(timeInterval)
        let pollVisibiltyOptions = generatePollVisibiltyDict()
        
        worker.createNewPoll(title: title, question: question, options: options, startDate: startDate, endDate: endDate, visiblity: pollVisibiltyOptions) {
            successful, error in
            guard error == nil else {
                self.output.presentError(string: error)
                return
            }
            if successful! {
                self.output.presentPollCreationCompleteScene()
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
    
    func timeIntervalFromDateComponents() -> Double {
        var totalSeconds = 0
        if let day = timeInterval?.day {
            totalSeconds += day * 24 * 60 * 60
            print("Total Seconds: \(totalSeconds)")
        }
        if let hours = timeInterval?.hour {
            totalSeconds += hours * 60 * 60
            print("Total Seconds: \(totalSeconds)")

        }
        if let seconds = timeInterval?.second {
            totalSeconds += seconds
            print("Total Seconds: \(totalSeconds)")
        }
        return Double(totalSeconds)
    }
    
    func fetchPollVisibiltyOptions() {
        if let targetSchool = targetSchool {
            output.presentPollVisiblityOptions(string: targetSchool.name)
        }
    }
}
