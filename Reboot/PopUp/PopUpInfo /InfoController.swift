//
//  InfoController.swift
//  Reboot
//
//  Created by Hovo on 11/12/20.
//

import UIKit
import Alamofire

class InfoController: BaseViewController {
    
    private let endPoint = "my/account/"
    var packages = [Packages]()
    
    //MARK: - IBOutlets
    @IBOutlet weak private var tableView: UITableView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        accountRequest()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.contentInset.top = 15
    }
    
    private func accountRequest() {
        NetWorkService.request(url: endPoint, method: .get, param: nil, encoding: JSONEncoding.prettyPrinted) { (resp: RequestResult<AccountResponse?>) in
            switch resp {
            case .success(let data):
                guard let data = data else {return}
                if let package = data?.packages {
                    self.packages = package
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - tableViewDelegate
extension InfoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if packages.count != 0 {
            return packages.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! InfoCell
        if packages.count != 0 {
            cell.packages.text = "До \(packages[indexPath.row].expirationDate?.UTCToLocal(incomingFormat: "yyyy-MM-dd", outGoingFormat: "dd MMM yyyy") ?? "")"
            cell.packegesCount.text = packages[indexPath.row].plan.title
        } 
        return cell
    }
}
