//
//  SignUpRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 8/7/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol SignUpRouterProtocol {
    
    weak var viewController: SignUpViewController? { get }
    
    func popViewController()
    func presentOTPScene(user: User?)
}

final class SignUpRouter {
    
    weak var viewController: SignUpViewController?
    
    
    // MARK: - Initializers
    
    init(viewController: SignUpViewController?) {
        
        self.viewController = viewController
    }
}


// MARK: - SignUpRouterProtocol

extension SignUpRouter: SignUpRouterProtocol {
    
    
    // MARK: - Navigation
    
    func presentOTPScene(user: User?) {
        if let otpViewController = viewController?.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.OTPScene) as? OTPViewController {
            otpViewController.output.email  = viewController?.output.email
            otpViewController.output.user = user
            viewController?.navigationController?.pushViewController(otpViewController, animated: true)
        }
    }
    
    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
