//
//  UserPageController.swift
//  Reboot
//
//  Created by Hovo on 11/12/20.
//

import UIKit
import Alamofire
import Kingfisher

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
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bonus: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    private var loyality : LoyaltyLevels?
    private var object = [Object]()
    
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
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.bottom = 5
        
    }
    
    private func accountRequest() {
        NetWorkService.request(url: Constants.MY_ACCOUNT_ENDPOINT, method: .get, param: nil, encoding: JSONEncoding.prettyPrinted) { (resp: RequestResult<AccountResponse?>) in
            switch resp {
            case .success(let model):
                guard let m = model, let finalModel = m else { return }
//                if let image = finalModel.avatar {
//                    self.userAvatar.setImage(urlString: image, placeholder: nil, completed: nil)
//                }
                self.bonus.text = String(finalModel.bonusesBalance)
                self.loyality = finalModel.loyaltyLevel
                if finalModel.firstName != ""{
                    self.userName.text = finalModel.firstName
                }else {
                    self.userName.text = finalModel.lastName
                }
                
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func reserveResponse() {
        indicator.startAnimating()
        NetWorkService.request(url: Constants.MY_RESERVES_ENDPOINT, method: .get, param: nil, encoding: JSONEncoding.prettyPrinted) { (resp: RequestResult<ReserveResp?>) in
            switch resp {
            case .success(let data):
                guard let data = data, let obj = data?.objects else {return}
                self.object = obj
                self.tableView.reloadData()
                self.userView.isHidden = true
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
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
            
        case .achievement:
            return 1
            
        case .info:
            return 1
            
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReserveCell", for: indexPath) as! ReserveCell
                cell.placeRoom.text = object[indexPath.row].workoutPlace.roomPlace.placeNumber
                cell.adress.text = object[indexPath.row].workout.workoutDay.room.slug
                cell.coachName.text = object[indexPath.row].workout.trainer.title
                cell.time.text = object[indexPath.row].workout.dateFrom.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss", outGoingFormat: "HH:mm")
                cell.date.text = object[indexPath.row].workout.dateFrom.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss", outGoingFormat: "dd.MM/")
                cell.backgroundColor = UIColor(named: "Cellcolors")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReservePageCell", for: indexPath) as! ReservePageCell
                cell.backgroundColor = UIColor(named: "Cellcolors")
                return cell
                
            }
           
        case .achievement:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AchievementsCell", for: indexPath) as! AchievementsCell
            cell.level.text = loyality?.title
            cell.cashBack.text = loyality?.description
//            cell.levelImage.setImage(urlString: loyality?.iconInactive, placeholder: nil, completed: nil)
            cell.backgroundColor = UIColor(named: "Cellcolors")
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrainingCell", for: indexPath) as! TrainingCell
            cell.backgroundColor = UIColor(named: "Cellcolors")
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReserveCell", for: indexPath) as! ReserveCell
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = SectionType(rawValue: section)
        if object.count != 0{
            let header = tableView.dequeueReusableCell(withIdentifier: "Header") as! Header
            header.title.text = sectionType?.getTitle()
            return header
        } else {
            let header = tableView.dequeueReusableCell(withIdentifier: "Header") as! Header
            header.backgroundColor = .clear
            header.title.textColor = .clear
            return header
        }
    
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionType = SectionType(rawValue: section)
        if sectionType == .reserve {
            let footer = tableView.dequeueReusableCell(withIdentifier: "Footer") as! Footer
            footer.reserveBtn.addTarget(self, action: #selector(selectedItem), for: .touchUpInside)
            return footer
            
        }
        
        let footer = tableView.dequeueReusableCell(withIdentifier: "Footer") as! Footer
        footer.backgroundColor = .clear
        return footer
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionType = SectionType(rawValue: section)
        if sectionType == .reserve {
            return 60
        }
        return 0.01
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = SectionType(rawValue: section)
        if sectionType == .reserve {
            if object.count == 0 {
                return 0.01
            } else {
                return 40
            }
        }
        return 0.01
    }
    
}
