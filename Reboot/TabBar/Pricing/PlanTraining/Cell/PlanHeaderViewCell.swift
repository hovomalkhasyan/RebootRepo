//
//  PlanHeaderViewCell.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 16.03.21.
//

import UIKit

class PlanHeaderViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setData()
    }

}


extension PlanHeaderViewCell {
   private func setData() {
        headerLabel.tintColor = UIColor.appOrangeColor
        let finalString = NSMutableAttributedString(string: "")
        finalString.withGiloryMadium("Разовый", size: 14).withColorGiloryMadium(" набор занятий, ").withGiloryMadium("доступный на определенный срок. Занятия можно использовать в любой студии.", size: 14)
        
        self.headerLabel.attributedText = finalString
    }
}
