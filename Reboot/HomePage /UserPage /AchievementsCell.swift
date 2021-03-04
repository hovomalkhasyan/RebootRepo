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
    @IBOutlet weak private var cashBack: UILabel!
    @IBOutlet weak private var level: UILabel!
    @IBOutlet weak private var levelImage: UIImageView!
    @IBOutlet weak private var achievementsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension AchievementsCell {
    func setData(model: Loyalty?) {
        self.level.text = model?.title
        self.cashBack.text = model?.description
//        if let image = model?.iconActive {
//            self.levelImage.setImage(urlString: Constants.imageUrl + image)
//        } else {
            self.levelImage.image = UIImage(named: "warrior_active")
//        }
    }
}
