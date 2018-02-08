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
    var schools = [School]()
    var faculties = [Faculty]()
    var sets = [String]()
    var departments = [Department]()    
    var dataType: DataType = .School
    
    
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
                    self.schoolData = schools.map{$0.name}
                    self.output.presentData()
                }
            }
        case .Faculty:
            output.presentData()
        case .Department:
            output.presentData()
        case .Set:
            output.presentData()
            
        }
    }
    
}
