//
//  UserPageController.swift
//  Reboot
//
//  Created by Hovo on 11/12/20.
//

import UIKit
import Alamofire
import Kingfisher

//MARK: - SectionType
enum SectionType: Int,CaseIterable {
    case reserve
    case achievement
    case info
    
    func getTitle() -> String {
        switch self {
        case .reserve:
            return "Предстоящие брони"
        case .achievement:
            return ""
        case .info:
            return ""
        }
    }
}

class UserPageController: BaseViewController {
    //MARK: - IBOutlets
    
    @IBOutlet weak private var indicator: UIActivityIndicatorView!
    @IBOutlet weak private var userView: UIView!
    @IBOutlet weak private var userAvatar: UIImageView!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var bonus: UILabel!
    @IBOutlet weak private var userName: UILabel!
    
    private var loyality : LoyaltyLevels?
    private var object = [Object]()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setbarView()
        super.setupGesture()
        super.setupDarkMode()
        super.workoutsCount()
        setupTableView()
        accountRequest()
        reserveResponse()
    }
    
    override func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension UserPageController {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.bottom = 0
        tableView.register(UINib(nibName: UserReservedCell.name, bundle: nil), forCellReuseIdentifier: UserReservedCell.name)
    }
    
    private func accountRequest() {
        NetWorkService.request(url: Constants.MY_ACCOUNT_ENDPOINT, method: .get, param: nil, encoding: JSONEncoding.prettyPrinted) { (resp: RequestResult<AccountResponse?>) in
            switch resp {
            case .success(let model):
                guard let m = model, let finalModel = m else { return }
                if let image = finalModel.avatar {
                    self.userAvatar.setImage(urlString: Constants.imageUrl + image, placeholder: nil, completed: nil)
                }
                self.bonus.text = String(finalModel.bonusesBalance)
                self.loyality = finalModel.loyaltyLevel
                self.userName.text = finalModel.fullName
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func reserveResponse() {
        //        indicator.startAnimating()
        NetWorkService.request(url: Constants.MY_RESERVES_ENDPOINT, method: .get, param: nil, encoding: JSONEncoding.prettyPrinted) { (resp: RequestResult<ReserveResp?>) in
            switch resp {
            case .success(let data):
                guard let data = data, let obj = data?.objects else {return}
                self.object = obj
                self.tableView.reloadData()
            //                self.userView.isHidden = true
            //                self.indicator.stopAnimating()
            //                self.indicator.hidesWhenStopped = true
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func selectedItem() {
        self.tabBarController?.selectedIndex = 1
    }
}

extension UserPageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = SectionType(rawValue: section)
        switch sectionType {
        case .reserve:
            if object.count != 0 {
                return object.count
            } else {
                return 1
            }
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = SectionType(rawValue: indexPath.section)
        switch sectionType {
        case .reserve:
            if object.count != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ReserveCell.name, for: indexPath) as! ReserveCell
                cell.setData(model: object[indexPath.row])
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ReservePageCell.name, for: indexPath) as! ReservePageCell
                return cell
            }
        case .achievement:
            let cell = tableView.dequeueReusableCell(withIdentifier: AchievementsCell.name, for: indexPath) as! AchievementsCell
            cell.setData(model: loyality)
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrainingCell.name, for: indexPath) as! TrainingCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReserveCell.name, for: indexPath) as! ReserveCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = SectionType(rawValue: section)
        if object.count != 0{
            let header = tableView.dequeueReusableCell(withIdentifier: Header.name) as! Header
            header.title.text = sectionType?.getTitle()
            return header
        } else {
            let header = tableView.dequeueReusableCell(withIdentifier: Header.name) as! Header
            header.backgroundColor = .clear
            header.title.textColor = .clear
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionType = SectionType(rawValue: section)
        if sectionType == .reserve {
            let footer = tableView.dequeueReusableCell(withIdentifier: Footer.name) as! Footer
            footer.reserveBtn.addTarget(self, action: #selector(selectedItem), for: .touchUpInside)
            return footer
        }
        
        let footer = tableView.dequeueReusableCell(withIdentifier: Footer.name) as! Footer
        footer.backgroundColor = .clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionType = SectionType(rawValue: section)
        if sectionType == .reserve {
            return 60
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = SectionType(rawValue: section)
        if sectionType == .reserve {
            if object.count == 0 {
                return 12
            } else {
                return 40
            }
        }
        return 12
    }
}
