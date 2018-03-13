//
//  PollCell.swift
//  SmartAlumni
//
//  Created by Jubril on 11/18/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import UIKit
import RealmSwift

class PollCell: UITableViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var optionStackView: UIStackView!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    var poll = Poll()
    var votedStackView: UIStackView?
    
    func setup(poll: Poll, viewController: PollsViewController) {
        self.poll = poll
        self.titleLabel.text = poll.name
        self.questionLabel.text = poll.question
        setupOptions(poll: poll, viewController: viewController)
        if (poll.endDate > Date()) {
            durationLabel.text = "\(poll.voters.count) Votes. \(poll.endDate.timeAgoSinceNow(useNumericDates: true)) left"
        }
        else {
            durationLabel.text = "\(poll.voters.count) Votes. Ended \(poll.endDate.timeAgoSinceNow(useNumericDates: true))"
            //displayVotedState(animated: false)
        }
    }
    
    override func prepareForReuse() {
        _ = optionStackView.arrangedSubviews.map{$0.removeFromSuperview()}
        votedStackView?.removeFromSuperview()
    }
    
    private func setupOptions(poll: Poll, viewController: PollsViewController) {
        optionStackView.alpha = 1
        optionStackView.isHidden = false
        for view in optionStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        if currentUserHasVoted() || pollHasEnded() {
            displayVotedState(animated: false)
        }
        else {
            displayUnvotedState()
        }
    }
    
    private func currentUserHasVoted() -> Bool {
        let realm = try! Realm()
        let user = realm.objects(User.self)[0]
        if let _ = poll.voters.first(where: {$0.userID == user.uid}) {
            return true
        }
        else{
            return false
        }
    }
    
    private func pollHasEnded() -> Bool{
        if (poll.endDate > Date()) {
            return false
            
        }
        else {
            return true
            
        }
    }
    
    func displayUnvotedState() {
        for (option) in poll.options {
            let optionView = OptionView.instanceFromNib()
            optionView.isUserInteractionEnabled = true
            optionView.translatesAutoresizingMaskIntoConstraints = false
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onOptionViewTap))
            optionView.addGestureRecognizer(tapGesture)
            optionView.pollCompletionIndicator.isHidden = true
            optionView.optionLabel.text = option.name
            optionView.progressLabel.isHidden = true
            optionView.option = option
            optionStackView.addArrangedSubview(optionView)
            optionView.widthAnchor.constraint(equalTo: optionStackView.widthAnchor, multiplier: 1).isActive = true
            optionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        layoutIfNeeded()
    }
    
    func displayVotedState(animated: Bool) {
        let realm = try! Realm()
        let user = realm.objects(User.self)[0]
        
        for (index, option) in poll.options.enumerated() {
            let optionView = OptionView.instanceFromNib()
            optionView.pollCompletionIndicator.isHidden = true
            setupProgressBarForOption(option: option, optionView, animated: false)
            if let voter = poll.voters.first(where: {$0.userID == user.uid}) {
                if (voter.selectedOption - 1) == index {
                    optionView.pollCompletionIndicator.isHidden = false
                }
            }
            optionView.optionLabel.text = option.name
            optionStackView.addArrangedSubview(optionView)
            optionView.widthAnchor.constraint(equalTo: optionStackView.widthAnchor, multiplier: 1).isActive = true
            optionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        layoutIfNeeded()
    }
    
    @objc func onOptionViewTap(sender: UITapGestureRecognizer) {
        if let optionView = sender.view as? OptionView {
            let realm = try! Realm()
            let user = realm.objects(User.self)[0]
            performVoteAnimationSequence(optionView: optionView)
            PollAPI.sharedManager.votePoll(pollID: poll.id, userID: user.uid, optionIndex: optionView.option.index) {
                voteComplete, error in
                if voteComplete {
                    
                }
                else {
                    
                }
            }
        }
    }
    
    
    func setupProgressBarForOption(option: PollOption, _ optionView: OptionView, animated: Bool) {
        if poll.voters.count > 0 {
            optionView.progressLabel.text = "\(Int( Double(option.numberOfVotes) / Double(poll.voters.count) * 100.0))%"
            optionView.fillUpBar(percentage: Double(Double(option.numberOfVotes) / Double(poll.voters.count) * 100.0), animated: animated)
        }
        else {
            optionView.progressLabel.text = "0%"
        }
    }
    
    func performVoteAnimationSequence(optionView: OptionView){
        let finalFrame = optionStackView.frame
        optionView.fillUpBar(percentage: 100, animated: false)
        delayWithSeconds(0.6) {
            self.optionStackView.animate(inParallel: [.fadeOut(duration: 0.2), .move(byX: (optionView.bounds.width * -0.75), y: 0)]).perform {
                self.optionStackView.isHidden = true
                self.optionStackView.frame = finalFrame
                self.addVotedPollOptionStackView(finalFrame: finalFrame, selectedOption: optionView.option)
            }
        }
    }
    
    func addVotedPollOptionStackView(finalFrame: CGRect, selectedOption: PollOption) {
        let votedStackView = UIStackView()
        self.votedStackView = votedStackView
        votedStackView.distribution = .fill
        votedStackView.spacing = 8
        votedStackView.axis = .vertical
        self.background.addSubview(votedStackView)
        votedStackView.frame = finalFrame
        for option in poll.options {
            let optionView = OptionView.instanceFromNib()
            optionView.option = option
            optionView.pollCompletionIndicator.isHidden = true
            if option.index == selectedOption.index {
                optionView.pollCompletionIndicator.isHidden = false
            }
            optionView.translatesAutoresizingMaskIntoConstraints = false
            optionView.optionLabel.text = option.name
            setupOptionViewIntermediateState(option: option, optionView)
            votedStackView.addArrangedSubview(optionView)
            optionView.widthAnchor.constraint(equalTo: votedStackView.widthAnchor, multiplier: 1).isActive = true
            optionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        layoutIfNeeded()
        votedStackView.frame.origin.x = votedStackView.frame.origin.x + 40
        votedStackView.alpha = 0
        votedStackView.animate([.move(byX: -40  , y: 0 , duration: 0.4), .fadeIn(duration: 0.4)]).perform {
            self.performBarFillingAnimation(stackView: votedStackView)
        }
        
    }
    
    func setupOptionViewIntermediateState(option: PollOption, _ optionView: OptionView) {
        if poll.voters.count > 0 {
            optionView.progressLabel.text = "\(Int( Double(option.numberOfVotes) / Double(poll.voters.count) * 100.0))%"
        }
        else {
            optionView.progressLabel.text = "0%"
        }
    }
    
    func performBarFillingAnimation(stackView: UIStackView) {
        for (index, option) in poll.options.enumerated() {
            
            print("Index: \(index)")
            let optionView = stackView.arrangedSubviews[index] as! OptionView
            let percentage = ( Double(option.numberOfVotes) / Double(poll.voters.count) * 100.0)
            print("Percentage: \(percentage)")
            optionView.fillUpBar(percentage: percentage, animated: true)
        }
    }
}
