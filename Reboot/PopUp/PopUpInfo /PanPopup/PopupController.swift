//
//  PopupController.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 19.02.21.
//

import UIKit
import PanModal
import Alamofire
class PopupController: UIViewController {
    //MARK: - tableView
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    
    //MARK: - propertyes
    var packages = [Packages]()
    
    //MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        accountRequest()
    }
}

//MARK: - SetupTableView
extension PopupController {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - accountRequest
extension PopupController {
    private func accountRequest() {
        NetWorkService.request(url: Constants.MY_ACCOUNT_ENDPOINT, method: .get, param: nil, encoding: JSONEncoding.prettyPrinted) { (resp: RequestResult<AccountResponse?>) in
            switch resp {
            case .success(let data):
                guard let data = data else {return}
                if let package = data?.packages {
                    self.packages = package
                }
                self.tableView.reloadData()
                self.loadingView.isHidden = true
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - tableViewDelegate
extension PopupController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if packages.count != 0 {
            return packages.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopupCell", for: indexPath) as! PopupCell
        if !packages.isEmpty {
            cell.packages.text = "До \(packages[indexPath.row].expirationDate?.UTCToLocal(incomingFormat: "yyyy-MM-dd", outGoingFormat: "dd MMM yyyy") ?? "")"
            cell.packegesCount.text = packages[indexPath.row].plan.title
            cell.packagesCounts.text = String(packages[indexPath.row].workoutsCount)
        }
        return cell
    }
}

//MARK: - PanModalSetup
extension PopupController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return tableView
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(200)
    }
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(100)
    }
    var cornerRadius: CGFloat {
        return 20
    }
}
