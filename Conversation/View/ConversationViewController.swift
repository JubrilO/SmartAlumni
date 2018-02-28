//
//  ConversationViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 2/15/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit
import MessageKit
import RealmSwift
import MapKit
import IQKeyboardManagerSwift

protocol ConversationViewControllerInput: ConversationPresenterOutput {

}

protocol ConversationViewControllerOutput {
    
    var currentSender: Sender {get}
    var chatRoom: ChatRoom {get set}
    var messages: [Message] {get set}
    func fetchMessages()
    func send(textMessage: Message)
    func closeConnection()
}

final class ConversationViewController: MessagesViewController {

    var output: ConversationViewControllerOutput!
    var router: ConversationRouterProtocol!


    // MARK: - Initializers

    init(configurator: ConversationConfigurator = ConversationConfigurator.sharedInstance) {

        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        configure()
    }


    // MARK: - Configurator

    private func configure(configurator: ConversationConfigurator = ConversationConfigurator.sharedInstance) {

        configurator.configure(viewController: self)
    }


    // MARK: - View lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()
        disableIQKeyboardManager()
        setupUI()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMessages()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        output.closeConnection()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        messagesCollectionView.contentInset.bottom = messageInputBar.frame.height
        messagesCollectionView.scrollIndicatorInsets.bottom = messageInputBar.frame.height
    }


    // MARK: - Load data
    
    func fetchMessages() {
        output.fetchMessages()
    }
    
    func disableIQKeyboardManager() {
        IQKeyboardManager.sharedManager().disabledDistanceHandlingClasses.append(ConversationViewController.self)
    }
    
    
    func presentActionSheet() {
      print("present action sheet")
    }
    
    func setupDelegates() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messageCellDelegate = self
        messageInputBar.delegate = self
    }
    
    // MARK: - Setup UI
    
    func defaultStyle() {
        let newMessageInputBar = MessageInputBar()
        newMessageInputBar.sendButton.tintColor = UIColor(red: 69/255, green: 193/255, blue: 89/255, alpha: 1)
        messageInputBar = newMessageInputBar
        reloadInputViews()
    }
    
    func setupLeftInputBarButtons() {
        let addButton = InputBarButtonItem()
        addButton.image = #imageLiteral(resourceName: "addInput")
        addButton.setSize(CGSize(width: 30, height: 30), animated: false)
        addButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        addButton.onTouchUpInside({_ in  self.presentActionSheet()})
        messageInputBar.leftStackView.addArrangedSubview(addButton)
        messageInputBar.setLeftStackViewWidthConstant(to: 40, animated: false)
    }
    
    func setupRightInputBarButtons() {
        let mediaButton = InputBarButtonItem()
        mediaButton.image = #imageLiteral(resourceName: "addMedia")
        mediaButton.setSize(CGSize(width: 36, height: 30), animated: false)
        mediaButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 1, bottom: 6, right: 2)
        messageInputBar.setStackViewItems([messageInputBar.sendButton, mediaButton], forStack: .right, animated: false)
        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        messageInputBar.sendButton.setSize(CGSize(width: 36, height: 36), animated: false)
        messageInputBar.setRightStackViewWidthConstant(to: 78, animated: false)
        messageInputBar.rightStackView.spacing = 10
        messageInputBar.sendButton.image = #imageLiteral(resourceName: "sendMessage")
        messageInputBar.sendButton.title = nil
        messageInputBar.sendButton.backgroundColor = .clear
    }

    func setupUI() {
        defaultStyle()
        messageInputBar.isTranslucent = true
        messageInputBar.backgroundColor = .clear
        messageInputBar.separatorLine.isHidden = true
        messageInputBar.inputTextView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        messageInputBar.inputTextView.placeholderTextColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 36)
        messageInputBar.inputTextView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
        messageInputBar.inputTextView.layer.borderWidth = 1.0
        messageInputBar.inputTextView.layer.cornerRadius = 16.0
        messageInputBar.inputTextView.layer.masksToBounds = true
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        messageInputBar.textViewPadding.right = -38
        messageInputBar.textViewPadding.top = 20
        setupRightInputBarButtons()
        setupLeftInputBarButtons()
    }
}


// MARK: - ConversationPresenterOutput

extension ConversationViewController: ConversationViewControllerInput {

    // MARK: - Display logic
    

    func displaySomething(viewModel: ConversationViewModel) {

        // TODO: Update UI
    }
    
    func displayError(string: String?) {
        displayErrorModal(error: string)
    }
    
    func displayMessages() {
        messagesCollectionView.reloadData()
    }
    
    func displayIncomingMessage() {
        messagesCollectionView.insertSections([output.messages.count - 1])
    }
}


// MARK: - MessagesDataSource

extension ConversationViewController: MessagesDataSource {
    
    func currentSender() -> Sender {
        let realm = try! Realm()
        let user = realm.objects(User.self)[0]
        let sender = Sender(id: user.uid, displayName: user.username)
        return sender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        let message = output.messages[indexPath.section]
        return message
    }
    
    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
        return output.messages.count
    }
}


extension ConversationViewController: MessagesDisplayDelegate {
    
    // MARK: - Text Messages
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .darkText
    }
    
    func detectorAttributes(for detector: DetectorType, and message: MessageType, at indexPath: IndexPath) -> [NSAttributedStringKey : Any] {
        return MessageLabel.defaultAttributes
    }
    
    func enabledDetectors(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> [DetectorType] {
        return [.url, .address, .phoneNumber, .date]
    }
    
    func messageHeaderView(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageHeaderView {
        let header = messagesCollectionView.dequeueReusableHeaderView(MessageDateHeaderView.self, for: indexPath)
        if let message = message as? Message {
            switch message.type {
            case .admin(let text):
                header.dateLabel.text = text
                return header
            default:
                break
            }
        }
        header.dateLabel.text = MessageKitDateFormatter.shared.string(from: message.sentDate)
        return header
    }
    
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let defaultAttributes: [NSAttributedStringKey: Any] = {
            return [
                NSAttributedStringKey.foregroundColor: UIColor(red: 143/255, green: 142/255, blue: 148/255, alpha: 1.0),
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13)
            ]
        }()
        if let message = message as? Message {
        switch message.type {
        case .text:
            return NSAttributedString(string: message.sender.displayName, attributes: defaultAttributes)
        default:
            return nil
        }
    }
        return nil
    }
    
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> Bool {
        if let message = message as? Message {
            switch message.type {
            case .admin:
                return true
            default:
                break
            }
        }
        guard let dataSource = messagesCollectionView.messagesDataSource else { return false }
        if indexPath.section == 0 { return false }
        let previousSection = indexPath.section - 1
        let previousIndexPath = IndexPath(item: 0, section: previousSection)
        let previousMessage = dataSource.messageForItem(at: previousIndexPath, in: messagesCollectionView)
        let timeIntervalSinceLastMessage = message.sentDate.timeIntervalSince(previousMessage.sentDate)
        return timeIntervalSinceLastMessage >= messagesCollectionView.showsDateHeaderAfterTimeInterval

    }
    
    // MARK: - All Messages
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        if let message = message as? Message {
            switch message.type {
            case .admin:
                return UIColor.clear
            default:
                break
            }
        }
        return isFromCurrentSender(message: message) ? UIColor(red: 107/255, green: 163/255, blue: 241/255, alpha: 1) : UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .pointedEdge)
        //        let configurationClosure = { (view: MessageContainerView) in}
        //        return .custom(configurationClosure)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        //let avatar = SampleData.shared.getAvatarFor(sender: message.sender)
        //avatarView.set(avatar: avatar)
    }
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    // MARK: - Location Messages
    func annotationViewForLocation(message: MessageType, at indexPath: IndexPath, in messageCollectionView: MessagesCollectionView) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: nil, reuseIdentifier: nil)
        let pinImage = UIImage()
        annotationView.image = pinImage
        annotationView.centerOffset = CGPoint(x: 0, y: -pinImage.size.height / 2)
        return annotationView
    }
    
    func animationBlockForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> ((UIImageView) -> Void)? {
        return { view in
            view.layer.transform = CATransform3DMakeScale(0, 0, 0)
            view.alpha = 0.0
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [], animations: {
                view.layer.transform = CATransform3DIdentity
                view.alpha = 1.0
            }, completion: nil)
        }
    }
    
    func snapshotOptionsForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LocationMessageSnapshotOptions {
        
        return LocationMessageSnapshotOptions()
    }
}

extension ConversationViewController: MessagesLayoutDelegate {
    
    func avatarPosition(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> AvatarPosition {
        return AvatarPosition(horizontal: .natural, vertical: .messageBottom)
    }
    
    func messagePadding(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIEdgeInsets {
        if isFromCurrentSender(message: message) {
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 4)
        } else {
            return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 30)
        }
    }
    
    func cellTopLabelAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LabelAlignment {
        if isFromCurrentSender(message: message) {
            return .messageTrailing(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
        } else {
            return .messageLeading(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        }
    }
    
    func cellBottomLabelAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LabelAlignment {
        if isFromCurrentSender(message: message) {
            return .messageLeading(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        } else {
            return .messageTrailing(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
        }
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        
        return CGSize(width: messagesCollectionView.bounds.width, height: 10)
    }
    
    // MARK: - Location Messages
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 200
    }
    
}

// MARK: - MessageCellDelegate
extension ConversationViewController: MessageCellDelegate {
    
    func didTapAvatar(in cell: MessageCollectionViewCell) {
        print("Avatar tapped")
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
        print("Message tapped")
    }
    
    func didTapTopLabel(in cell: MessageCollectionViewCell) {
        print("Top label tapped")
    }
    
    func didTapBottomLabel(in cell: MessageCollectionViewCell) {
        print("Bottom label tapped")
    }
    
}

// MARK: - MessageLabelDelegate
extension ConversationViewController: MessageLabelDelegate {
    
    func didSelectAddress(_ addressComponents: [String : String]) {
        print("Address Selected: \(addressComponents)")
    }
    
    func didSelectDate(_ date: Date) {
        print("Date Selected: \(date)")
    }
    
    func didSelectPhoneNumber(_ phoneNumber: String) {
        print("Phone Number Selected: \(phoneNumber)")
    }
    
    func didSelectURL(_ url: URL) {
        print("URL Selected: \(url)")
    }
    
}


extension ConversationViewController: MessageInputBarDelegate {
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        print("send button clicked")
        print("New text:\(text)")
        let user = try! Realm().objects(User.self)[0]
        let messageID = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        print(messageID)
        for component in inputBar.inputTextView.components {
            if let image = component as? UIImage {
                let imageMessage = Message(sender: user, image: image, type: .image(imageurl: ""), messageID: messageID, chatRoomID: output.chatRoom.id  )
                output.messages.append(imageMessage)
                messagesCollectionView.insertSections([output.messages.count - 1])
            }
            else if let text = component as? String {
                let textMessage = Message(sender: user, text: text, type: .text, messageID: messageID, chatRoomID: output.chatRoom.id)
                output.send(textMessage: textMessage)
                output.messages.append(textMessage)
                messagesCollectionView.insertSections([output.messages.count - 1])
            }
        }
        
        inputBar.inputTextView.text = ""
        messagesCollectionView.scrollToBottom(animated: true)
    }
}
