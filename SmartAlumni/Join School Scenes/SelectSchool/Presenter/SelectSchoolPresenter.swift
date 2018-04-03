//
//  SelectSchoolPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 8/24/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol SelectSchoolPresenterInput: SelectSchoolInteractorOutput {
    
}

protocol SelectSchoolPresenterOutput: class {
    
    func displaySchools(viewModels: [SelectSchoolViewModel])
    func displayError(errorMessage: String?)
}

final class SelectSchoolPresenter {
    
    private(set) weak var output: SelectSchoolPresenterOutput!
    
    
    // MARK: - Initializers
    
    init(output: SelectSchoolPresenterOutput) {
        
        self.output = output
    }
}


// MARK: - SelectSchoolPresenterInput

extension SelectSchoolPresenter: SelectSchoolPresenterInput {
    
    
    // MARK: - Presentation logic
    
    func presentError(errorMessage: String?) {
        output.displayError(errorMessage: errorMessage)
    }
    
    func presentSchools(schools: [School]) {
        var viewModels = [SelectSchoolViewModel]()
        for school in schools {
            let viewModel = SelectSchoolViewModel(schoolName: school.name)
            viewModels.append(viewModel)
        }
        output.displaySchools(viewModels: viewModels)
    }
    
    func presentSearchResults(schools: [School]) {
    
        var viewModels = [SelectSchoolViewModel]()
        for school in schools {
            let viewModel = SelectSchoolViewModel(schoolName: school.name)
            viewModels.append(viewModel)
        }
        output.displaySchools(viewModels: viewModels)
    }
}
