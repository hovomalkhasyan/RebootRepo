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
    
    @IBOutlet weak var tableView: UITableView!
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
                guard let data = data, let package = data?.packages else {return}
                self.packages = package
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension InfoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packages.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! InfoCell
        cell.packages.text = "До \(packages[indexPath.row].expirationDate?.UTCToLocal(incomingFormat: "yyyy-MM-dd", outGoingFormat: "dd MMM yyyy") ?? "")"
        cell.packegesCount.text = packages[indexPath.row].plan.title
        return cell
        
    }
    
}
