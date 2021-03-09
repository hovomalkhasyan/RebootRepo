//
//  LogOutViewController.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 09.03.21.
//

import UIKit

class LogOutViewController: BaseViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    private let cells: [RebootLogOut] = RebootLogOut.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupInfoBtn()
        setbarView()
        setupInfoBtn()
//        workoutsCount()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Setup
extension LogOutViewController {
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 20
    }
    
    private func setupViews() {
        logo.image = UIImage(named: "Group 6544")
    }
}

//MARK: - TableViewDataSource
extension LogOutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogOutCell", for: indexPath) as! LogOutCell
        cell.setPopUpType(cells[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 5:
            showAlert(with: "Выйти", message: "Выйти из аккаунта?")
        default:
            let url = cells[indexPath.row].url
            let vc = AboutUsDetailsController.initializeStoryboard()
            vc.webViewUrl = url
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - showPopUp
extension LogOutViewController {
    private func showAlert(with title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
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
    }
}

//MARK: - LogoutEnum
enum RebootLogOut: String, CaseIterable {
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
