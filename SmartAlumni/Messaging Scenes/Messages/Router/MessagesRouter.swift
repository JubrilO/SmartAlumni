//
//  MessagesRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 12/11/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol MessagesRouterProtocol {

    weak var viewController: MessagesListViewController? { get }

    func navigateToChatRoom(chatRoom: ChatRoom)
    func navigateToJoinSchoolScene()
}

final class MessagesRouter {

    weak var viewController: MessagesListViewController?


    // MARK: - Initializers

    init(viewController: MessagesListViewController?) {

        self.viewController = viewController
    }
}


// MARK: - MessagesRouterProtocol

extension MessagesRouter: MessagesRouterProtocol {


    // MARK: - Navigation

    func navigateToChatRoom(chatRoom: ChatRoom) {
        let chatRoomVC = ConversationViewController()
       chatRoomVC.output.chatRoom = chatRoom
        //chatRoomVC.dataSource = DemoChatDataSource(count: 0, pageSize: 50)
        chatRoomVC.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(chatRoomVC, animated: true)
    }
    
    func navigateToJoinSchoolScene() {
        let joinSchoolStoryBoard = UIStoryboard(name: Constants.StoryboardNames.JoinSchool, bundle: nil)
        let schoolCategoryVC = joinSchoolStoryBoard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.SelectSchoolCategoryScene)
        let navVC = UINavigationController(rootViewController: schoolCategoryVC)
        viewController?.present(navVC, animated: true, completion: nil)
    }
}
