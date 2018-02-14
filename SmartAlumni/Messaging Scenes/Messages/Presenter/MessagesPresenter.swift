//
//  MessagesPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 12/11/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol MessagesPresenterInput: MessagesInteractorOutput {

}

protocol MessagesPresenterOutput: class {
    func displayChatRooms()
    func displayError(errorString: String?)

}

final class MessagesPresenter {

    private(set) weak var output: MessagesPresenterOutput!


    // MARK: - Initializers

    init(output: MessagesPresenterOutput) {

        self.output = output
    }
}


// MARK: - MessagesPresenterInput

extension MessagesPresenter: MessagesPresenterInput {


    // MARK: - Presentation logic

    func presentChatRooms() {
        output.displayChatRooms()
    }
    
    func presentError(errorString: String?) {
        output.displayError(errorString: errorString)
    }
}
