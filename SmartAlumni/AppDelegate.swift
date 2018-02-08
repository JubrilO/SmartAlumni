//
//  AppDelegate.swift
//  SmartAlumni
//
//  Created by Jubril on 7/31/17.
//  Copyright © 2017 Kornet. All rights reserved.
//

import UIKit
import Locksmith
import RealmSwift
import Firebase
import Fabric
import Crashlytics
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let realm = try! Realm()
        let signUpStage1 = UserDefaults.standard.bool(forKey: Constants.UserDefaults.SignUpStage1)
        let signUpStage2 = UserDefaults.standard.bool(forKey: Constants.UserDefaults.SignUpStage2)
        let signUpStage3 = UserDefaults.standard.bool(forKey: Constants.UserDefaults.SignUpStage3)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if signUpStage1 {
            if let OTPVC = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.OTPScene) as? OTPViewController {
                let navVC = UINavigationController(rootViewController: OTPVC)
                self.window?.rootViewController = navVC
                self.window?.makeKeyAndVisible()
            }
        }
        else if signUpStage2 {
            if let signUpVC = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.EditProfileScene) as? EditProfileViewController {
                let navVC = UINavigationController(rootViewController: signUpVC)
                self.window?.rootViewController = navVC
                self.window?.makeKeyAndVisible()
            }
        }
        else if signUpStage3 {
            let joinSchoolStoryBoard = UIStoryboard(name: Constants.StoryboardNames.JoinSchool, bundle: nil)
            if let selectSchoolCategoryVC = joinSchoolStoryBoard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.SelectSchoolCategoryScene) as? SelectSchoolCategoryVC {
                let navVC = UINavigationController(rootViewController: selectSchoolCategoryVC)
                self.window?.rootViewController = navVC
                self.window?.makeKeyAndVisible()
            }
        }
        else if realm.objects(User.self).isEmpty {
            let navVC = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.InitialNavScene)
            self.window?.rootViewController = navVC
            self.window?.makeKeyAndVisible()
        }
        else {
            let landingStoryboard = UIStoryboard(name: "Landing", bundle: nil)
            let landingTabBar = landingStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifiers.LandingTabBarScene)
            self.window?.rootViewController = landingTabBar
            self.window?.makeKeyAndVisible()
        }
        
        IQKeyboardManager.sharedManager().enable = true
        Fabric.with([Crashlytics.self])
        return true
    }
    
}

