//
//  AchievementsCell.swift
//  Reboot
//
//  Created by Hovo on 11/16/20.
//

import UIKit

class AchievementsCell: UITableViewCell {

    @IBOutlet weak var achievments: UILabel!
    @IBOutlet weak var activity: UILabel!
    @IBOutlet weak var cashBack: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var levelImage: UIImageView!
    @IBOutlet weak var achievementsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
