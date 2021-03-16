//
//  SubscriptionsViewController.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 16.03.21.
//

import UIKit
import Alamofire
class SubscriptionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var planArray = [PlansList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        getSubscriptions()
    }
}

extension SubscriptionsViewController {
    private func getSubscriptions() {
        NetWorkService.request(url: Constants.PLANS_API, method: .get, param: nil, encoding: JSONEncoding.prettyPrinted) { (resp: RequestResult<PlanModel?>) in
            switch resp {
            case .success(let model):
                guard let model = model, let finalModel = model else { return }
                self.planArray = finalModel.objects.first(where: { $0.id == 1 })?.plansList ?? []
                self.tableView.reloadData()
                print(finalModel)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SubscriptionsViewController {
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SubscriptionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubscriptionsCell.name, for: indexPath) as! SubscriptionsCell
        cell.setData(model: planArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: HeaderSubViewCell.name) as! HeaderSubViewCell
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 140
    }
}
extension SubscriptionsViewController {
    static func initializeStoryboard() -> SubscriptionsViewController {
        return UIStoryboard(name: "Subscriptions", bundle: nil).instantiateViewController(withIdentifier: "SubscriptionsViewController") as! SubscriptionsViewController
    }
}

