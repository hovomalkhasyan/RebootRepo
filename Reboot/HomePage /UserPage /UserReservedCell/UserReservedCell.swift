//
//  UserReservedCell.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 30.01.21.
//

import UIKit

class UserReservedCell: UITableViewCell {

    @IBOutlet weak var reserveLabel: UILabel!
    @IBOutlet weak var reservedView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

//MARK: - setup
extension UserReservedCell {
    private func setup() {
        reservedView.layer.cornerRadius = 10
        reservedView.layer.borderColor = UIColor.lightGray.cgColor
        reservedView.layer.borderWidth = 0.1
        UIColor.black.withAlphaComponent(0.16)
        reservedView.layer.shadowColor =  UIColor.black.withAlphaComponent(0.16).cgColor
        reservedView.layer.shadowRadius = 10
        reservedView.layer.shadowOffset = CGSize(width: 0, height: 1)
        reservedView.layer.shadowOpacity = 1
        reservedView.layer.shadowRadius = 3
    }
}
