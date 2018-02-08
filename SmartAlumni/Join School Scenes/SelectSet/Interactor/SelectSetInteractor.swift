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
    var selectedFaculty: Faculty?
    var selectedDepartment: Department?
    var selectedSet: Int?
    
    
    
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
        var options = [""]
        print(school.faculties.count)
        switch optionType {
        case .faculty:
            options = school.faculties.map {$0.name}
            print(options.count)
        case .department:
            options = school.departments.map {$0.name}
        case .set:
            options += school.sets
        }
        output.presentOptions(options: options)
        
    }
    
    func joinSet() {
        
        worker.joinSchool(schoolID: school.id, facultyID: selectedFaculty?.id, departmentID: selectedDepartment?.id, set: selectedSet!) {
            
            success, error in
            
            if success {
                print("Joined school successfully")
                UserDefaults.standard.set(false, forKey: Constants.UserDefaults.SignUpStage3)
                self.output.presentJoinSchoolCompletion()
            }
            else {
                self.output.presentError(errorMessage: error)
            }
        }
    }
}

