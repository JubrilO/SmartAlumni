//
//  PollsViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 10/27/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit
import Segmentio

protocol PollsViewControllerInput: PollsPresenterOutput {

}

protocol PollsViewControllerOutput {
    var polls: [Poll] {get set}
    func doSomething()
}

final class PollsViewController: UIViewController {

    var output: PollsViewControllerOutput!
    var router: PollsRouterProtocol!
    @IBOutlet weak var emptyStateImageView: UIImageView!
    @IBOutlet weak var segmentioView: Segmentio!
    @IBOutlet weak var emptyStateLabel1: UILabel!
    @IBOutlet weak var emptyStateLabel2: UILabel!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Initializers

    init(configurator: PollsConfigurator = PollsConfigurator.sharedInstance) {

        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        configure()
    }


    // MARK: - Configurator

    private func configure(configurator: PollsConfigurator = PollsConfigurator.sharedInstance) {

        configurator.configure(viewController: self)
    }


    // MARK: - View lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()
        self.title = "Polls"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        setupSegmentio()
        
    }


    // MARK: - Load data

    func doSomethingOnLoad() {

        output.doSomething()
    }
    
    @IBAction func onNewPollButtonTouch(_ sender: UIButton) {
        router.navigateToNewPollScene()
    }
    
    func showEmptyState() {
        emptyStateImageView.isHidden = false
        emptyStateLabel1.isHidden = false
        emptyStateLabel2.isHidden = false
    }
    
    func hideEmptyState() {
        emptyStateImageView.isHidden = true
        emptyStateLabel1.isHidden = true
        emptyStateLabel2.isHidden = true
    }
    
    func setupSegmentio() {
        var content = [SegmentioItem]()
        let ongoingItem = SegmentioItem(title: "Ongoing", image: nil)
        let completedItem = SegmentioItem(title: "Completed", image: nil)
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
}


// MARK: - PollsPresenterOutput

extension PollsViewController: PollsViewControllerInput {


    // MARK: - Display logic

    func displaySomething(viewModel: PollsViewModel) {

        // TODO: Update UI
    }
}

extension PollsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.PollCell) as! PollCell
        let poll = output.polls[indexPath.row]
        cell.setup(poll: poll)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.polls.count
    }
    
}
