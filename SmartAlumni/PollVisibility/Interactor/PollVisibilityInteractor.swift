//
//  PollVisibilityInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 11/23/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol PollVisibilityInteractorInput: PollVisibilityViewControllerOutput {
    
}

protocol PollVisibilityInteractorOutput {
    
    func presentSchools()
    func presentFaculties()
    func presentDepartments()
}

final class PollVisibilityInteractor: PollVisibilityViewControllerOutput  {
    
    let output: PollVisibilityInteractorOutput
    let worker: PollVisibilityWorker
    
    var schools = [School]()
    var pickerData = [String]()
    var departments = [Department]()
    var faculties = [Faculty]()
    var targetSchool = School()
    var targetDeparments = [Department]()
    var targetFaculties = [Faculty]()
    var targetSets = [String]()

    
    
    
    // MARK: - Initializers
    
    init(output: PollVisibilityInteractorOutput, worker: PollVisibilityWorker = PollVisibilityWorker()) {
        
        self.output = output
        self.worker = worker
    }
    
    
    // MARK: - PollVisibilityInteractorInput
    
    
    // MARK: - Business logic
    
    func fetchSchools() {
        
        
        if schools.isEmpty {
            worker.fetchSchools {
                schools, error in
                guard error == nil else {
                    print(error!)
                    return
                }
                if let schools = schools {
                    print("school count: \(schools.count)")
                    self.schools = schools
                    self.pickerData = schools.map{$0.name}
                    self.output.presentSchools()
                }
            }
        }
    }
    
    func fetchFaculties(schoolIndex: Int) {
       let selectedSchool =  schools[schoolIndex]
        pickerData = selectedSchool.faculties.map{$0.name}
        output.presentFaculties()
    }
    
    func fetchDepartments() {
    
    }
    
    func fetchSets() {
        
    }
    
}
