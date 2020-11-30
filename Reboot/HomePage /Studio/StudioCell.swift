//
//  StudioCell.swift
//  Reboot
//
//  Created by Hovo on 11/11/20.
//

import UIKit

class StudioCell: UITableViewCell {

    @IBOutlet weak var studioName: UILabel!
    @IBOutlet weak var studioView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        studioViewSetup()
        
    }
    
    private func studioViewSetup() {
        studioView.layer.cornerRadius = 10
        studioView.layer.borderColor = UIColor.lightGray.cgColor
        studioView.layer.borderWidth = 0.1
        studioView.layer.shadowColor = UIColor.black.withAlphaComponent(0.16).cgColor
        studioView.layer.shadowRadius = 10
        studioView.layer.shadowOffset = CGSize(width: 0, height: 1)
        studioView.layer.shadowOpacity = 1
        studioView.layer.shadowRadius = 3
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
