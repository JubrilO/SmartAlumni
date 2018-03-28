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
    @IBOutlet weak var goalAndReadMoreSpacingConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewAndProgressBarSpacingConstriant: NSLayoutConstraint!
    
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
        setupSpacingForSmallerDevices()
        progressView.setProgress(Float(self.output.project.percentageCompletion()/100), animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func onFundProjectButtonClick(_ sender: UIButton) {
        router.navigateToFundProject(project: output.project)
    }
    
    @IBAction func onReadMoreButtonClick(_ sender: UIButton) {
        
    }
    // MARK: - Load datat
    
    func setupSpacingForSmallerDevices() {
        if view.bounds.width < 375 {
            goalAndReadMoreSpacingConstraint.constant = 7
            stackViewAndProgressBarSpacingConstriant.constant = 15
            view.layoutIfNeeded()
        }
    }
    
    func fetchProject() {
        output.fetchProject()
    }
}


// MARK: - ProjectDetailPresenterOutput

extension ProjectDetailViewController: ProjectDetailViewControllerInput {
    
    
    // MARK: - Display logicz
    
    func displayProject(viewModel: ProjectDetailViewModel) {
        
        // TODO: Update UI
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.descriptionString
        descriptionLabel.text = "Spielberg’s blockbuster, “Minority Report”, is set in the year 2054. The future – at least according to a team of MIT futurologists, hired by the cinematic genius – is the captive of embarrassingly personalized and disturbingly intrusive, mostly outdoor, interactive advertising."
        goalLabel.text = viewModel.totalAmount
        imageView.kf.setImage(with: viewModel.imageURL)
        progressLabel.text = viewModel.precentageCompletion
        donorsLabel.text = viewModel.donorCount
        daysLeftLabel.text = viewModel.daysLeft
        readMoreButton.isHidden = true
        if descriptionLabel.numberOfVisibleLines >= 4 {
            readMoreButton.isHidden = false
        }
    }
}
