//
//  PollVisibilityPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 11/23/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol PollVisibilityPresenterInput: PollVisibilityInteractorOutput {
}

protocol PollVisibilityPresenterOutput: class {
    func displayTargetSchool(school: String)
    func displayTargetDepartments(departments: String)
    func displayTargetFaculties(faculties: String)
    func displayTargetSets(sets: String)
}

final class PollVisibilityPresenter {

    private(set) weak var output: PollVisibilityPresenterOutput!


    // MARK: - Initializers

    init(output: PollVisibilityPresenterOutput) {

        self.output = output
    }
}


// MARK: - PollVisibilityPresenterInput

extension PollVisibilityPresenter: PollVisibilityPresenterInput {
   
    // MARK: - Presentation logic
    
    func presentSelectedSchool(school: School) {
        output.displayTargetSchool(school: school.name)
    }
    
    func presentSelectedFaculties(faculties: [Faculty]) {
        let facultyNamesArray = faculties.map{$0.name}
        let facultiesString = formatStringArray(array: facultyNamesArray)
        output.displayTargetFaculties(faculties: facultiesString)
    }
    
    func presentSelectedSets(sets: [String]) {
        let setsString = formatStringArray(array: sets)
        output.displayTargetSets(sets: setsString)
    }
    
    func presentSelectedDeparments(departments: [Department]) {
        let departmentNamesArray = departments.map{$0.name}
        let departmentsString = formatStringArray(array: departmentNamesArray)
        output.displayTargetDepartments(departments: departmentsString)
    }
    
    func formatStringArray(array: [String]) -> String {
        var string = String()
        for (i, element) in array.enumerated() {
            if i+1 != array.count {
                string += element + ", "
            }
            else {
                string += element
            }
        }
        return string
    }
    
    func presentSchools() {
        
    }
    
    func presentFaculties() {
    }
    
    func presentDepartments() {
    }

}
