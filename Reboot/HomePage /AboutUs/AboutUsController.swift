//
//  AboutUsController.swift
//  Reboot
//
//  Created by Hovo on 11/10/20.
//

import UIKit
import SafariServices

class AboutUsController: BaseViewController {
    
    var urlArray = ["https://reboot.ru/welcome/about-reboot",
                    "https://reboot.ru/workouts/o-trenirovkakh",
                    "https://reboot.ru/trainers",
                    "https://reboot.ru/press/blog",
                    "https://reboot.ru/corporate",
                     "https://reboot.ru/terms/pravila"]
    
    private let textArray = ["О нас", "Тренировки", "Тренеры", "Блог", "Business", "Правила"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setbarView()
        super.setupGesture()
        super.setupDarkMode()
        setupTableView()
        setbarView()
        super.workoutsCount()
    }
    
    override func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        
    }
    
    private func setupNavigation() {
        navigationController?.isNavigationBarHidden = true
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 20
        
    }

}

extension AboutUsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath) as! AboutCell
        cell.textLb.text = textArray[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: urlArray[indexPath.row])
        let safariController = SFSafariViewController(url: url!)
        present(safariController, animated: true, completion: nil)
        
    }
    
}

