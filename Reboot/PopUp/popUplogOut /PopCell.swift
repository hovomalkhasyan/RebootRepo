//
//  PopCell.swift
//  Reboot
//
//  Created by Hovo on 11/11/20.
//

import UIKit

class PopCell: UITableViewCell {

    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var popLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorIsHide()
    }
    
    private func separatorIsHide() {
        separator.isHidden = true
    }
}

extension PopCell {
    public func setPopUpType(_ type: RebootPopUp){
        popLb.text = type.title
    }
}
