//
//  ProjectsViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 3/5/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit
import Segmentio
import Kingfisher

protocol ProjectsViewControllerInput: ProjectsPresenterOutput {

}

protocol ProjectsViewControllerOutput {

    var projects: [Project] {get set}
    func fetchProjects()
}

final class ProjectsViewController: UIViewController {

    var output: ProjectsViewControllerOutput!
    var router: ProjectsRouterProtocol!

    @IBOutlet weak var segmentioView: Segmentio!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterButton: UIButton!
    
    // MARK: - Initializers

    init(configurator: ProjectsConfigurator = ProjectsConfigurator.sharedInstance) {

        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        configure()
    }


    // MARK: - Configurator

    private func configure(configurator: ProjectsConfigurator = ProjectsConfigurator.sharedInstance) {

        configurator.configure(viewController: self)
    }


    // MARK: - View lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "Projects"
        setupSegmentio()
        output.fetchProjects()
    }
    
    func setupSegmentio() {
        segmentioView.valueDidChange = { [unowned self] (_ segmentio: Segmentio, _ selectedSegmentioIndex: Int) in
//            switch selectedSegmentioIndex {
//            case 0:
//                //self.output.loadOngoingPolls()
//            case 1:
//                //self.output.loadCompletedPolls()
//            default:
//                //self.output.loadOngoingPolls()
//            }
        }
        var content = [SegmentioItem]()
        let ongoingItem = SegmentioItem(title: "Funding", image: nil)
        let completedItem = SegmentioItem(title: "Execution", image: nil)
        let indicatorOptions = SegmentioIndicatorOptions(type: .bottom, ratio: 1, height: 2, color: Constants.Colors.softBlue)
        let states = SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: .clear,
                titleFont: UIFont.systemFont(ofSize: 15),
                titleTextColor: Constants.Colors.darkGrey
            ),
            selectedState: SegmentioState(
                backgroundColor: .clear,
                titleFont: UIFont.systemFont(ofSize: 15),
                titleTextColor: Constants.Colors.softBlue
            ),
            highlightedState: SegmentioState(
                backgroundColor: .clear,
                titleFont: UIFont.systemFont(ofSize: 15),
                titleTextColor: .black
            )
        )
        let options = SegmentioOptions(backgroundColor: .white, segmentPosition: .dynamic, scrollEnabled: true, indicatorOptions: indicatorOptions, horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(type: .topAndBottom, height: 0), verticalSeparatorOptions: nil, imageContentMode: .center, labelTextAlignment: .center, labelTextNumberOfLines: 1, segmentStates: states, animationDuration: 0.3)
        content.append(ongoingItem)
        content.append(completedItem)
        segmentioView.selectedSegmentioIndex = 0
        segmentioView.setup(content: content, style: .onlyLabel, options: options)
    }

    // MARK: - Actions


    @IBAction func onFilterButtonClick(_ sender: UIButton) {
        
    }
    
    @IBAction func onNewPollButtonClick(_ sender: UIBarButtonItem) {
        
    }
    
    
    // MARK: - Load data

    func doSomethingOnLoad() {

        // TODO: Ask the Interactor to do some work

    }
}


// MARK: - ProjectsPresenterOutput

extension ProjectsViewController: ProjectsViewControllerInput {


    // MARK: - Display logic

    func displayProjects() {
        collectionView.reloadData()
    }
}

extension ProjectsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let project = output.projects[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.ProjectCell, for: indexPath) as! ProjectsCollectionViewCell
        cell.titleLabel.text = project.title
        cell.schoolNameLabel.text = project.schoolName
        cell.setLabel.text = "\(project.set) Set"
        let url = URL(string: project.imageURL)
        cell.projectImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.3))], progressBlock: nil, completionHandler: nil)
        return cell
    }
}

extension ProjectsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let aspectRatio: CGFloat = 178/238
        let availablewidth = collectionView.bounds.width - 12
       let  width = availablewidth/2
        let height = width/aspectRatio
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
}
