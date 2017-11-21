//
//  SelectSetInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 8/29/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol SelectSetInteractorInput: SelectSetViewControllerOutput {
    
}

protocol SelectSetInteractorOutput {
    
    func presentOptions(options: [String])
    func presentJoinSchoolCompletion()
    func presentError(errorMessage: String?)
}

final class SelectSetInteractor: SelectSetViewControllerOutput{
    var school: School = School()


    
    let output: SelectSetInteractorOutput
    let worker: SelectSetWorker
    
    
    
    // MARK: - Initializers
    
    init(output: SelectSetInteractorOutput, worker: SelectSetWorker = SelectSetWorker()) {
        
        self.output = output
        self.worker = worker
    }
    
    
    // MARK: - SelectSetInteractorInput
    
    
    
    // MARK: - Business logic
    
    func updatePickerOptions(optionType: OptionType) {
        var options = [String]()
        print(school.faculties.count)
        switch optionType {
        case .faculty:
            options = school.faculties.map {$0.name}
            print(options.count)
        case .department:
            options = school.departments.map {$0.name}
        case .set:
            options = school.sets
        }
        output.presentOptions(options: options)
        
    }
    
    func joinSet(faculty: String, department: String, set: String) {
        
        let facultyID = school.faculties.filter { $0.name == faculty }.first?.id
        let departmentID = school.departments.filter { $0.name == department }.first?.id
        let set = Int(set)
        
        if let facultyID = facultyID, let departmentID = departmentID, let set = set {            
            worker.joinSchool(schoolID: school.id, facultyID: facultyID, departmentID: departmentID, set: set) {
                
                success, error in
                
                if success {
                    print("Joined school successfully")
                    self.output.presentJoinSchoolCompletion()
                }
                else {
                    self.output.presentError(errorMessage: error)
                }
            }
        }
        
        else {
            print("could not get all required parameters")
        }
    
    }
    
}
