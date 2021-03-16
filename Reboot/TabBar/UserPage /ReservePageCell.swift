//
//  ReservePageCell.swift
//  Reboot
//
//  Created by Hovo on 11/16/20.
//

import UIKit

class ReservePageCell: UITableViewCell {
  
    @IBOutlet weak var reserveImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        reserveImage.image = UIImage(named: "Calendar X")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            
            let imageView = UIImage(named: "Calendar X")
            let tintableImage = imageView?.withRenderingMode(.alwaysTemplate)
            reserveImage.image = tintableImage
            reserveImage.tintColor = UIColor(named: "Color")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
