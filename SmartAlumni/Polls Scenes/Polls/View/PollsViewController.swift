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
    func fetchPolls()
    func loadOngoingPolls()
    func loadCompletedPolls()
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
        fetchPolls()
        

        self.title = "Polls"
        // Hide line under navbar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        setupSegmentio()
        
    }


    // MARK: - Load data

    func fetchPolls() {
        output.fetchPolls()
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
    
    @objc func onOptionViewTap(sender: UITapGestureRecognizer){
        print("Tap Gesture")
    }
    
    func setupSegmentio() {
        segmentioView.valueDidChange = { [unowned self] (_ segmentio: Segmentio, _ selectedSegmentioIndex: Int) in
            switch selectedSegmentioIndex {
            case 0:
                self.output.loadOngoingPolls()
            case 1:
               self.output.loadCompletedPolls()
            default:
                self.output.loadOngoingPolls()
            }
        }
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
    
    func displayPolls() {
        tableView.reloadData()
        if output.polls.count < 1 {
            tableView.isHidden = true
        }
        else {
            tableView.isHidden = false
        }
    }
    
    func displayError(error: String) {
        displayErrorModal(error: error)
    }
}

extension PollsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.PollCell) as! PollCell
        let poll = output.polls[indexPath.row]
        cell.setup(poll: poll, viewController: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.polls.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.PollCell) as! PollCell
        let poll = output.polls[indexPath.row]
        currentCell.setup(poll: poll, viewController: self)
        let questionLabelHeight = currentCell.questionLabel.textHeight
        let titleLabelHeight = currentCell.titleLabel.textHeight
        let questionNumberOfLines = currentCell.questionLabel.numberOfVisibleLines
        let titleNumberofLines =
            currentCell.titleLabel.numberOfVisibleLines
        if currentCell.questionLabel.numberOfVisibleLines > 1 || currentCell.titleLabel.numberOfVisibleLines > 1 {
            let titleHeight = ((titleLabelHeight - 19 + 2) * CGFloat((titleNumberofLines - 1)))
            let questionHeight = ((questionLabelHeight - 14 + 1)   * CGFloat((questionNumberOfLines - 1)))
            print("More than one line")
            return 200.0 + (49.0 * CGFloat(poll.options.count - 1) + questionHeight + titleHeight)
        }
        return 200.0 + (49.0 * CGFloat(poll.options.count - 1))
    }
    
}
