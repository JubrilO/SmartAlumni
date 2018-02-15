//
//  MessagesViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 12/11/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol MessagesViewControllerInput: MessagesPresenterOutput {

}

protocol MessagesViewControllerOutput {
    
    var chatRooms: [ChatRoom] {get set}
    func fetchChatRooms()
}

final class MessagesListViewController: UIViewController {

    var output: MessagesViewControllerOutput!
    var router: MessagesRouterProtocol!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Initializers

    init(configurator: MessagesConfigurator = MessagesConfigurator.sharedInstance) {

        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        configure()
    }


    // MARK: - Configurator

    private func configure(configurator: MessagesConfigurator = MessagesConfigurator.sharedInstance) {

        configurator.configure(viewController: self)
    }


    // MARK: - View lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        fetchChatRooms()
        activityIndicator.startAnimating()
    }


    // MARK: - Load data
    
   func fetchChatRooms() {
        output.fetchChatRooms()
    }

}


// MARK: - MessagesPresenterOutput

extension MessagesListViewController: MessagesViewControllerInput {


    // MARK: - Display logic

    func displayChatRooms() {
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    func displayError(errorString: String?) {
        displayErrorModal(error: errorString)
    }
}


// MARK: - UITableViewDataSource

extension MessagesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.MessageCell) as! MessageTableViewCell
        let chatRoom = output.chatRooms[indexPath.row]
        cell.nameLabel.text = chatRoom.name
        cell.messageLabel.text = chatRoom.lastMessage?.content
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd/MM/yy"
        dateFormatter.doesRelativeDateFormatting = true
        if let date = chatRoom.lastMessage?.timeStamp {
            print("Date Object \(date)")
            cell.timeLabel.text = date.timeAgoSinceNow(useNumericDates: true)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.chatRooms.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedChatRoom = output.chatRooms[indexPath.row]
        router.navigateToChatRoom(chatRoomID: selectedChatRoom.id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
}
