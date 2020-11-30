//
//  InfoCell.swift
//  Reboot
//
//  Created by Hovo on 11/12/20.
//

import UIKit

class InfoCell: UITableViewCell {

    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var packages: UILabel!
    @IBOutlet weak var packegesCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
