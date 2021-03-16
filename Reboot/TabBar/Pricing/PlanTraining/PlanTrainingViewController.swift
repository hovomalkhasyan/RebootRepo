//
//  PlanTrainingViewController.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 16.03.21.
//

import UIKit
import Alamofire

class PlanTrainingViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    private var planArray = [PlansList]()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
    }
}

//MARK: - SetupDelegate
extension PlanTrainingViewController {
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
//MARK: - GetPlans
extension PlanTrainingViewController {
    private func getPlans() {
        NetWorkService.request(url: Constants.PLANS_API, method: .get, param: nil, encoding: JSONEncoding.prettyPrinted) { (resp: RequestResult<PlanModel?>) in
            switch resp {
            case .success(let model):
                guard let model = model, let finalModel = model else { return }
                self.planArray = finalModel.objects.first(where: { $0.id == 2 })?.plansList ?? []
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - TableViewMethods
extension PlanTrainingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrainingPlanCell.name, for: indexPath) as! TrainingPlanCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: PlanHeaderViewCell.name) as! PlanHeaderViewCell
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}

//MARK: - initializeStoryboard
extension PlanTrainingViewController {
    static func initializeStoryboard() -> PlanTrainingViewController {
        return UIStoryboard(name: "TrainingPlan", bundle: nil).instantiateViewController(withIdentifier: "PlanTrainingViewController") as! PlanTrainingViewController
    }
}
