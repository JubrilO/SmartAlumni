//
//  ChatRoomViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 3/22/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit
import Chatto
import ChattoAdditions

protocol ChatRoomViewControllerInput: ChatRoomPresenterOutput {

}

protocol ChatRoomViewControllerOutput {

    func doSomething()
}

final class ChatRoomViewController: BaseChatViewController {

    var output: ChatRoomViewControllerOutput!
    var router: ChatRoomRouterProtocol!
    var chatInputPresenter: BasicChatInputBarPresenter!


    // MARK: - Initializers

    init(configurator: ChatRoomConfigurator = ChatRoomConfigurator.sharedInstance) {

        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        configure()
    }


    // MARK: - Configurator

    private func configure(configurator: ChatRoomConfigurator = ChatRoomConfigurator.sharedInstance) {

        configurator.configure(viewController: self)
    }


    // MARK: - View lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()

        doSomethingOnLoad()
    }
    
    override func createChatInputView() -> UIView {
        let chatInputView = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
        appearance.sendButtonAppearance.title = NSLocalizedString("Send", comment: "")
        appearance.textInputAppearance.placeholderText = NSLocalizedString("Type a message", comment: "")
        self.chatInputPresenter = BasicChatInputBarPresenter(chatInputBar: chatInputView, chatInputItems: self.createChatInputItems(), chatInputBarAppearance: appearance)
        chatInputView.maxCharactersCount = 1000
        return chatInputView
    }
    
    
    func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
        items.append(self.createPhotoInputItem())
        return items
    }
    
    private func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            // Your handling logic
        }
        return item
    }
    
    private func createPhotoInputItem() -> PhotosChatInputItem {
        let item = PhotosChatInputItem(presentingController: self)
        item.photoInputHandler = { [weak self] image in
            // Your handling logic
        }
        return item
    }


    // MARK: - Load data

    func doSomethingOnLoad() {

        // TODO: Ask the Interactor to do some work

        output.doSomething()
    }
}


// MARK: - ChatRoomPresenterOutput

extension ChatRoomViewController: ChatRoomViewControllerInput {


    // MARK: - Display logic

    func displaySomething(viewModel: ChatRoomViewModel) {

        // TODO: Update UI
    }
}
