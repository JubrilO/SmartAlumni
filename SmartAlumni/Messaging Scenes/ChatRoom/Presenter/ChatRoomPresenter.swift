//
//  ChatRoomPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 2/14/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ChatRoomPresenterInput: ChatRoomInteractorOutput {

}

protocol ChatRoomPresenterOutput: class {

    func displaySomething(viewModel: ChatRoomViewModel)
}

final class ChatRoomPresenter {

    private(set) weak var output: ChatRoomPresenterOutput!


    // MARK: - Initializers

    init(output: ChatRoomPresenterOutput) {

        self.output = output
    }
}


// MARK: - ChatRoomPresenterInput

extension ChatRoomPresenter: ChatRoomPresenterInput {


    // MARK: - Presentation logic

    func presentSomething() {

        // TODO: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = ChatRoomViewModel()
        output.displaySomething(viewModel: viewModel)
    }
}
