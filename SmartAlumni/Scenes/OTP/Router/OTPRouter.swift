//
//  OTPRouter.swift
//  SmartAlumni
//
//  Created by Jubril on 8/13/17.
//  Copyright (c) 2017 Kornet. All rights reserved.
//

import UIKit

protocol OTPRouterProtocol {
    
    weak var viewController: OTPViewController? { get }
    
    func popViewController()
    func routeToEditProfile()
    func routeToLanding()
}

final class OTPRouter {
    
    weak var viewController: OTPViewController?
    
    
    // MARK: - Initializers
    
    init(viewController: OTPViewController?) {
        
        self.viewController = viewController
    }
}


// MARK: - OTPRouterProtocol

extension OTPRouter: OTPRouterProtocol {
    
    
    // MARK: - Navigation
    
    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToEditProfile() {
        if let editProfileVC = viewController?.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.EditProfileScene) {
            viewController?.navigationController?.pushViewController(editProfileVC, animated: true)
        }
    }
    
    func routeToLanding() {
        let landingStoryboard = UIStoryboard(name: "Landing", bundle: nil)
        let landingVC = landingStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.LandingTabBarScene)
        viewController?.present(landingVC, animated: true, completion: nil)
    }
}

