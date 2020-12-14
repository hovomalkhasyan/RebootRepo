//
//  AboutUsController.swift
//  Reboot
//
//  Created by Hovo on 11/10/20.
//

import UIKit
import SafariServices

class AboutUsController: BaseViewController {
    
    private let cells: [RebootAddressRowEnum] = RebootAddressRowEnum.allCases
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setbarView()
        super.setupGesture()
        super.setupDarkMode()
        super.workoutsCount()
        setupTableView()
        setbarView()
        
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
        return cells.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath) as! AboutCell
        cell.setType(cells[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: cells[indexPath.row].url)
        let safariController = SFSafariViewController(url: url!)
        present(safariController, animated: true, completion: nil)
        
    }
    
}

enum RebootAddressRowEnum: String, CaseIterable {
    case aboutUs = "about_us"
    case workouts = "my_workouts"
    case coaches = "my_coaches"
    case blog = "my_blog"
    case business = "my_business"
    case rules = "my_rules"
    
    var title: String {
        switch self {
        case .aboutUs:
            return ConstantStrings.ABOUT_US
        case .workouts:
            return ConstantStrings.REBOOT_WORKOUTS
        case .coaches:
            return ConstantStrings.REBOOT_COACHES
        case .blog:
            return ConstantStrings.REBOOT_BLOG
        case .business:
            return ConstantStrings.REBOOT_BUSINESS
        case .rules:
            return ConstantStrings.REBOOT_RULES
        }
    }
    
    var url: String {
        switch self {
        case .aboutUs:
            return ConstantStrings.ABOUT_REBOOT
        case .workouts:
            return ConstantStrings.ABOUT_WORKOUT
        case .coaches:
            return ConstantStrings.ABOUT_COACHES
        case .blog:
            return ConstantStrings.ABOUT_BLOG
        case .business:
            return ConstantStrings.BUSINESS
        case .rules:
            return ConstantStrings.RULES
        }
    }
    
}


