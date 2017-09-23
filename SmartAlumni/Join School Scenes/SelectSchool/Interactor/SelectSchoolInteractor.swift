//
//  SelectSchoolInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 8/24/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol SelectSchoolInteractorInput: SelectSchoolViewControllerOutput {

}

protocol SelectSchoolInteractorOutput {
    
    func presentError(errorMessage: String)
    func presentSchools(schools: [School])
    func presentSearchResults(schools: [School])
}

final class SelectSchoolInteractor {
    
    let output: SelectSchoolInteractorOutput
    let worker: SelectSchoolWorker
    
    var seachResults = [School]()
    var schools = [School]()
    
    
    // MARK: - Initializers
    
    init(output: SelectSchoolInteractorOutput, worker: SelectSchoolWorker = SelectSchoolWorker()) {
        
        self.output = output
        self.worker = worker
    }
}


// MARK: - SelectSchoolInteractorInput

extension SelectSchoolInteractor: SelectSchoolViewControllerOutput {
    
    
    // MARK: - Business logic
    
    func fetchAllSchools() {
        
        // TODO: Create some Worker to do the work
        
        worker.fetchAllSchools {
            schools, error in
            
            guard error == nil else {
                self.output.presentError(errorMessage: error!)
                return
            }
            
            if let schools = schools {
                self.schools = schools
                self.output.presentSchools(schools: schools)
            }
        }
    }
    
    func updateSearchResults(searchText: String) {
        
        if searchText == "" {
            output.presentSearchResults(schools: schools)
        }
        else {
            seachResults = schools.filter  {
                school in
                return school.name.lowercased().range(of: searchText.lowercased()) != nil
            }
            output.presentSearchResults(schools: seachResults)
        }
    }
    
    func routeToSchool(index: Int) {
        let school = schools[index]
    }
}
