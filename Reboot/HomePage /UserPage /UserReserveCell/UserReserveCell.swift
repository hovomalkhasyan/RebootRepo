//
//  UserReserveCell.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 30.01.21.
//

import UIKit

class UserReserveCell: UITableViewCell {

    @IBOutlet weak var reserveImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setData()
    }
}

extension UserReserveCell {
    func setData() {
        reserveImage.image = UIImage(named: "Calendar X")
        reserveImage.setImageColor(color: UIColor(named: "Color")!)
    }
}
