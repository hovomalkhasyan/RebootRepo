//
//  PopUpController.swift
//  Reboot
//
//  Created by Hovo on 11/11/20.
//

import UIKit
import SafariServices

class PopUpController: UIViewController {
    
    private let infoArray = ["Бронирования", "Покупки", "Личные Данные", "Пригласи Друга", "План Тренировок", "Выйти"]
    
    private let urlArray = ["https://reboot.ru/account/reservations",
                            "https://reboot.ru/account/packages",
                            "https://reboot.ru/account",
                            "https://reboot.ru/account/referrals",
                            "https://reboot.ru/account/training-plan"]
    
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
        return infoArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopCell", for: indexPath) as! PopCell
            cell.popLb.text = infoArray[indexPath.row]
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
            let url = URL(string: urlArray[indexPath.row])
            let safariController = SFSafariViewController(url: url!)
            present(safariController, animated: true, completion: nil)
            
        }
    }

}

