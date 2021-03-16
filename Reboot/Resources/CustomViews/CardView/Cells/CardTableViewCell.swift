//
//  CardTableViewCell.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 16.03.21.
//

import UIKit
class CardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardCode: UILabel!
    @IBOutlet weak var cardType: UIImageView!
    @IBOutlet weak var checkBoxView: CheckboxButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxView.circular = true
    }
}


