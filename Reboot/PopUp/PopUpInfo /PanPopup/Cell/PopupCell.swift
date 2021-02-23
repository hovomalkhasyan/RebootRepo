//
//  PopupCell.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 19.02.21.
//

import UIKit

class PopupCell: UITableViewCell {
    
    @IBOutlet weak var packages: UILabel!
    @IBOutlet weak var packegesCount: UILabel!
    @IBOutlet weak var packagesCounts: UILabel!
    @IBOutlet weak var pacagesView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
