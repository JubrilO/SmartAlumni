//
//  VisibilityOptionInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 11/28/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol VisibilityOptionInteractorInput: VisibilityOptionViewControllerOutput {
    
}

protocol VisibilityOptionInteractorOutput {
    
    func presentData()
}

final class VisibilityOptionInteractor: VisibilityOptionViewControllerOutput {
    
    
    let output: VisibilityOptionInteractorOutput
    let worker: VisibilityOptionWorker
    var schoolData = [String]()
    var schools = [School]() {
        didSet {
           schools = schools.sorted{ school1 , school2 in return school1.name < school2.name}
        }
    }
    var faculties = [Faculty]() {
        didSet {
            faculties = faculties.sorted{faculty1, faculty2 in return faculty1.name < faculty2.name}
        }
    }
    var sets = [String]() {
        didSet {
            sets = sets.sorted{ set1, set2 in return set1 < set2}
        }
    }
    var departments = [Department]() {
        didSet {
            departments = departments.sorted{ dept1, dept2 in return dept1.name < dept2.name}
        }
    }
    var dataType: DataType = .School
    var targetSchool: School?
    var targetSets: [String]?
    var targetFaculties: [Faculty]?
    var targetDepartments: [Department]?
    
    
    // MARK: - Initializers
    
    init(output: VisibilityOptionInteractorOutput, worker: VisibilityOptionWorker = VisibilityOptionWorker()) {
        
        self.output = output
        self.worker = worker
    }
    
    
    
    // MARK: - Business logic
    
    func fetchData() {
        switch dataType {
        case .School:
            worker.fetchSchools {
                schools, error in
                guard error == nil else {
                    print(error!)
                    return
                }
                if let schools = schools {
                    self.schools = schools
                        //.sorted{$0.name > $1.name}
                    self.schoolData = schools.map{$0.name}
                        //.sorted{$0 > $1}
                    self.output.presentData()
                }
            }
        case .Faculty:
            schoolData = faculties.map{$0.name}
            output.presentData()
        case .Department:
            schoolData = departments.map{$0.name}
            output.presentData()
        case .Set:
            schoolData = sets
            output.presentData()
            
        }
    }
    
}
