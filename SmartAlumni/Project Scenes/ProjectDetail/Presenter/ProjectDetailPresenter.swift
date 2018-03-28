//
//  ProjectDetailPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 3/15/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ProjectDetailPresenterInput: ProjectDetailInteractorOutput {

}

protocol ProjectDetailPresenterOutput: class {

    func displayProject(viewModel: ProjectDetailViewModel)
}

final class ProjectDetailPresenter {

    private(set) weak var output: ProjectDetailPresenterOutput!


    // MARK: - Initializers

    init(output: ProjectDetailPresenterOutput) {

        self.output = output
    }
}


// MARK: - ProjectDetailPresenterInput

extension ProjectDetailPresenter: ProjectDetailPresenterInput {


    // MARK: - Presentation logic

    func presentProject(project: Project) {

        // TODO: Format the response from the Interactor and pass the result back to the View Controller
        let daysLeft = project.numberOfDaysLeft() ?? 0
        let timeLeftLabelText = daysLeft == 1 ? "day left" : "days left"
        let donorsLabelText = project.donors.count == 1 ? "donor" : "donors"

        let viewModel = ProjectDetailViewModel(title: project.title.capitalized, descriptionString: project.description, totalAmount: "Goal: ₦\(project.amount.formattedAmount())", imageURL: URL(string: project.imageURL), precentageCompletion: "\(project.percentageCompletion())%", donorCount: String(project.donors.count), daysLeft: String(daysLeft), timeLeftLabelText: timeLeftLabelText)
        output.displayProject(viewModel: viewModel)
    }
}

extension Double {
    func formattedAmount() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        guard let number =  numberFormatter.string(from: NSNumber(value: self)) else {return "0"}
        return number
    }
}
