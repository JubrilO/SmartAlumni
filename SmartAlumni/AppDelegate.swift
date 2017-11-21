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
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        
        let realm = try! Realm()
        if realm.objects(User.self).isEmpty {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
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
       return true
    }

}

