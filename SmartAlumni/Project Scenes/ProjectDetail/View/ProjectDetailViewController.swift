//
//  ProjectDetailViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 3/15/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ProjectDetailViewControllerInput: ProjectDetailPresenterOutput {
    
}

protocol ProjectDetailViewControllerOutput {
    
    var project: Project {get set}
    func fetchProject()
}

final class ProjectDetailViewController: UIViewController {
    
    var output: ProjectDetailViewControllerOutput!
    var router: ProjectDetailRouterProtocol!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var donorsLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var fundProjectButton: UIButton!
    
    // MARK: - Initializers
    
    init(configurator: ProjectDetailConfigurator = ProjectDetailConfigurator.sharedInstance) {
        
        super.init(nibName: nil, bundle: nil)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configure()
    }
    
    
    // MARK: - Configurator
    
    private func configure(configurator: ProjectDetailConfigurator = ProjectDetailConfigurator.sharedInstance) {
        
        configurator.configure(viewController: self)
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fetchProject()
        //self.hideNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressView.setProgress(Float(self.output.project.percentageCompletion()/100), animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func onFundProjectButtonClick(_ sender: UIButton) {
        
    }
    
    @IBAction func onReadMoreButtonClick(_ sender: UIButton) {
        
    }
    // MARK: - Load data
    
    func fetchProject() {
        output.fetchProject()
    }
    
    func setupProjectDetails() {
        
        titleLabel.text = output.project.title.capitalized
        descriptionLabel.text = output.project.description
        goalLabel.text = "Goal: NGN \(output.project.amount)"
        imageView.kf.setImage(with: URL(string: output.project.imageURL))
        progressLabel.text = "\(output.project.percentageCompletion())%"
        donorsLabel.text = String(output.project.donors.count)
        if let days = output.project.numberOfDaysLeft() {
            daysLeftLabel.text = String(days)
        }
    }
    
    func doSomethingOnLoad() {
        
        // TODO: Ask the Interactor to do some work
        
    }
}


// MARK: - ProjectDetailPresenterOutput

extension ProjectDetailViewController: ProjectDetailViewControllerInput {
    
    
    // MARK: - Display logicz
    
    func displayProject(viewModel: ProjectDetailViewModel) {
        
        // TODO: Update UI
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.descriptionString
        goalLabel.text = viewModel.totalAmount
        imageView.kf.setImage(with: viewModel.imageURL)
        progressLabel.text = viewModel.precentageCompletion
        donorsLabel.text = viewModel.donorCount
        daysLeftLabel.text = viewModel.daysLeft
    }
}
