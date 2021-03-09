//
//  LogOutCell.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 09.03.21.
//

import UIKit

class LogOutCell: UITableViewCell {
    
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupView() {
        aboutView.backgroundColor  = UIColor(named: "cellColour")
        label.textColor = UIColor(named: "textColor")
        aboutView.layer.cornerRadius = 10
        aboutView.layer.borderColor = UIColor.lightGray.cgColor
        aboutView.layer.borderWidth = 0.1
        aboutView.layer.shadowColor = UIColor.black.withAlphaComponent(0.16).cgColor
        aboutView.layer.shadowRadius = 10
        aboutView.layer.shadowOffset = CGSize(width: 0, height: 1)
        aboutView.layer.shadowRadius = 3
        aboutView.layer.shadowOpacity = 1
    }
    
}

extension LogOutCell {
    public func setPopUpType(_ type: RebootLogOut){
        label.text = type.title
    }
}
