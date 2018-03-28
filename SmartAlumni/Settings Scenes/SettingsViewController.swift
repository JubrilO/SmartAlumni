//
//  SettingsViewController.swift
//  SmartAlumni
//
//  Created by Jubril on 3/28/18.
//  Copyright © 2018 Kornet. All rights reserved.
//

import UIKit
import RealmSwift

class SettingsViewController: UITableViewController {
    
    let settingsStoryboard = UIStoryboard(name: "Settings", bundle: nil)
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var saveImages: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        let user = realm.objects(User.self)[0]
        profileNameLabel.text = user.firstName + " " + user.lastName
        profileImageView.kf.setImage(with: URL(string: user.profileImage))
        saveImages.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("case 0")
        case 1:
            switch indexPath.row{
            case 1:
                pushNotificationScene()
            case 2:
                pushChatBackupScene()
            default:
                print("Default case")
            }
        case 2:
            switch indexPath.row {
            case 0:
                pushPrivacyScene()
            case 1:
                print("Push change number")
            case 2:
                pushDeleteAccountScene()
            case 3:
                print("Push mansge sets")
            default:
                break
            }
        case 3:
            pushHelpScene()
            
        default:
            break
        }
    }
    
    func pushNotificationScene() {
        
        let notificationVC = settingsStoryboard.instantiateViewController(withIdentifier: "NotificationsScene")
        navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    func pushChatBackupScene() {
        let chatBackupVC  = settingsStoryboard.instantiateViewController(withIdentifier: "ChatBackupScene")
        navigationController?.pushViewController(chatBackupVC, animated: true)
    }
    
    func pushPrivacyScene() {
        let privacyVC = settingsStoryboard.instantiateViewController(withIdentifier: "privacyScene")
        navigationController?.pushViewController(privacyVC, animated: true)
    }
    
    func push2FAPasswordScene() {
        let twoFAPasswordVC = settingsStoryboard.instantiateViewController(withIdentifier: "2faScene")
        navigationController?.pushViewController(twoFAPasswordVC, animated: true)
    }
    
    func pushBlockedUsersScene() {
        let blockedUsersVC = settingsStoryboard.instantiateViewController(withIdentifier: "blockedUsersVC")
        navigationController?.pushViewController(blockedUsersVC, animated: true)
    }
    
    func pushDeleteAccountScene() {
        let deleteAccountVC = settingsStoryboard.instantiateViewController(withIdentifier: "DeleteAccountScene")
        navigationController?.pushViewController(deleteAccountVC, animated: true)
    }
    
    func pushHelpScene() {
        let helpVC = settingsStoryboard.instantiateViewController(withIdentifier: "HelpScene")
        navigationController?.pushViewController(helpVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        header.textLabel?.textColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1.0)
    }

}
