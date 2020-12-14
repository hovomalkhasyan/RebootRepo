//
//  StudioController.swift
//  Reboot
//
//  Created by Hovo on 11/11/20.
//

import UIKit
import SafariServices

class StudioController: BaseViewController {
    
    private let cells: [RebootStudioRowEnum] = RebootStudioRowEnum.allCases
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setbarView()
        super.setupGesture()
        super.setupDarkMode()
        super.workoutsCount()
        setbarView()
        setupTableView()
        
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
        return cells.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudioCell", for: indexPath) as! StudioCell
        cell.setStudioCellType(cells[indexPath.row])
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: cells[indexPath.row].rebootAddressUrl)
        let safariController = SFSafariViewController(url: url!)
        present(safariController, animated: true, completion: nil)
        
    }
    
}

enum RebootStudioRowEnum: String, CaseIterable {
    case rebootEast
    case rebootSW
    
    var title: String {
        switch self {
        case .rebootEast:
            return ConstantStrings.REBOOT_EAST
        case .rebootSW:
            return ConstantStrings.REBOOT_SW
        }
    }
    
    var rebootAddressUrl: String {
        switch self {
        case .rebootEast:
            return ConstantStrings.REBOOT_ADDRESS_EAST
        case .rebootSW:
            return ConstantStrings.REBOOT_ADDRESS_SW
        }
    }
}
