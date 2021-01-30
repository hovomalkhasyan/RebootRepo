//
//  UserAchivemntsCell.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 30.01.21.
//

import UIKit

class UserAchivemntsCell: UITableViewCell {

    @IBOutlet weak var cashBackLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak private var activityImage: UILabel!
    @IBOutlet weak private var activityLabel: UILabel!
    @IBOutlet weak private var achievementsLabel: UILabel!
    @IBOutlet weak private var achievementsImage: UIImageView!
    @IBOutlet weak private var levelImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension UserAchivemntsCell {
    public func setData(with data: LoyaltyLevels?) {
        cashBackLabel.text = data?.description
        levelLabel.text = data?.title
    }
}
