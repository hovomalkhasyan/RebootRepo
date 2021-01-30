//
//  PopUpController.swift
//  Reboot
//
//  Created by Hovo on 11/11/20.
//

import UIKit
import SafariServices

class PopUpController: UIViewController {
 
    private let cells: [RebootPopUp] = RebootPopUp.allCases

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.contentInset.top = 15
        tableView.contentInset.bottom = 15
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    
}

extension PopUpController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopCell", for: indexPath) as! PopCell
        cell.setPopUpType(cells[indexPath.row])
        if indexPath.row == 4 {
            cell.separator.isHidden = false
        }
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 5:
            let alert = UIAlertController(title: "Выйти", message: "Выйти из аккаунта?", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Выйти", style: .default) { (alert) in
                let loginStory = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Navigation")
                if #available(iOS 13, *) {
                    UIApplication.shared.windows.first?.rootViewController = loginStory
                    
                } else {
        
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = loginStory
                    
                }
                
                UserDefaults.standard.removeObject(forKey: "token")
            }
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        default:
            let url = URL(string: cells[indexPath.row].url)
            let safariController = SFSafariViewController(url: url!)
            present(safariController, animated: true, completion: nil)
            
        }
    }
}

enum RebootPopUp: String, CaseIterable {
    case bookings
    case purchases
    case personalInformation
    case inviteaFriend
    case trainingPlan
    case logOut
    
    var title: String {
        switch self {
        case .bookings:
            return ConstantStrings.REBOOT_BOOKINGS
        case .purchases:
            return ConstantStrings.REBOOT_PURCHASES
        case .personalInformation:
            return ConstantStrings.PERSONAL_INFORMATION
        case .inviteaFriend:
            return ConstantStrings.INVITE_A_FRIEND
        case .trainingPlan:
            return ConstantStrings.TRAINING_PLAN
        case .logOut:
            return ConstantStrings.LOG_OUT
        }
    }
    
    var url: String {
        switch self {
        case .bookings:
            return ConstantStrings.REBOOT_BOOKINGS_URL
        case .purchases:
            return ConstantStrings.REBOOT_PURCHASES_URL
        case .personalInformation:
            return ConstantStrings.PERSONAL_INFORMATION_URL
        case .inviteaFriend:
            return ConstantStrings.INVITE_A_FRIEND_URL
        case .trainingPlan:
            return ConstantStrings.TRAINING_PLAN_URL
        case .logOut:
           return ""
        }
    }
}

extension PopUpController {
    private func showAlert(with title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
    }
}
