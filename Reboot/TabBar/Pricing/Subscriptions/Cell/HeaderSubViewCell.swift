//
//  HeaderSubViewCell.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 16.03.21.
//

import UIKit

class HeaderSubViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setDataForSubscriptions()
    }
    
}
extension HeaderSubViewCell {
    private func setDataForSubscriptions() {
        headerLabel.tintColor = UIColor.appOrangeColor
        let finalString = NSMutableAttributedString(string: "")
        finalString.withGiloryMadium("Подписки", size: 14).withColorGiloryMadium(" продлеваются ").withGiloryMadium("автоматически по истечению указанного срока действия. Доступны 2 типа подписки - на месяц (30 дней) и 1 год (365 дней). Отключить или заморозить автопродление можно в любое время. Занятия можно использовать в любой студии.", size: 14)
        self.headerLabel.attributedText = finalString
    }
}
