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
  
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
 
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setbarView()
        setupGesture()
        setupInfoBtn()
        setupDarkMode()
        hideNavBar()
        setbarView()
        setupTableView()
//        workoutsCount()
    }
    
    override func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()
        
    }
    
}

//MARK: - Extension 
extension StudioController {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
    
//MARK: - TAbleViewDataSource
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
        let webWiev = AboutUsDetailsController.initializeStoryboard()
        webWiev.webViewUrl = cells[indexPath.row].rebootAddressUrl
        self.navigationController?.pushViewController(webWiev, animated: true)
    }
}

//MARK: - RebootStudioEnum
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
