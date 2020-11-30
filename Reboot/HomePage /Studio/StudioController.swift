//
//  StudioController.swift
//  Reboot
//
//  Created by Hovo on 11/11/20.
//

import UIKit
import SafariServices

class StudioController: BaseViewController {
    private let urlArray = ["https://reboot.ru/registration?studio=reboot_east&day",
                             "https://reboot.ru/registration?studio=reboot-sw&day"]
    private let studioArray = ["REBOOT EAST на Павелецкой", "REBOOT SW на Хамовниках"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setbarView()
        super.setupGesture()
        super.setupDarkMode()
        setbarView()
        setupTableView()
        super.workoutsCount()
    }
    
    override func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    private func setupNavigation() {
        navigationController?.isNavigationBarHidden = true
        
    }
    
}

extension StudioController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studioArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudioCell", for: indexPath) as! StudioCell
        
        cell.studioName.text = studioArray[indexPath.row]
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: urlArray[indexPath.row])
        let safariController = SFSafariViewController(url: url!)
        present(safariController, animated: true, completion: nil)
        
    }
    
}

