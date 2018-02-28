//
//  ConversationPresenter.swift
//  SmartAlumni
//
//  Created by Jubril on 2/15/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit

protocol ConversationPresenterInput: ConversationInteractorOutput {

}

protocol ConversationPresenterOutput: class {
    
    func displayError(string: String?)
    func displayMessages()
    func displayIncomingMessage()
    func displaySomething(viewModel: ConversationViewModel)
}

final class ConversationPresenter {

    private(set) weak var output: ConversationPresenterOutput!


    // MARK: - Initializers

    init(output: ConversationPresenterOutput) {

        self.output = output
    }
}


// MARK: - ConversationPresenterInput

extension ConversationPresenter: ConversationPresenterInput {
    
    // MARK: - Presentation logic
    
    func presentSocketConnected() {
        
    }
    
    func presentMessageSent() {
        
    }
    
    func presentMessages() {
        output.displayMessages()
    }
    
    func presentIncomingMessage(message: Message) {
        output.displayIncomingMessage()
    }
    
    func presentError(error: Error?) {
        output.displayError(string: error?.localizedDescription)
    }

    func presentSomething() {

        // TODO: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = ConversationViewModel()
        output.displaySomething(viewModel: viewModel)
    }
}
