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
    @IBOutlet weak var activityImage: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var achievementsLabel: UILabel!
    @IBOutlet weak var achievementsImage: UIImageView!
    @IBOutlet weak var levelImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
