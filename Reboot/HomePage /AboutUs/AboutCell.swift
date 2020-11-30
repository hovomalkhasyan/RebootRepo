//
//  AboutCell.swift
//  Reboot
//
//  Created by Hovo on 11/10/20.
//

import UIKit

class AboutCell: UITableViewCell {

    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var textLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        
    }

    private func setupView() {
//
//        switch traitCollection.userInterfaceStyle {
//        case .dark:
//            textLb.textColor = UIColor(red: 38/255, green: 34/255, blue: 49/255, alpha: 1)
//            aboutView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
//        case .light:
//            aboutView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
//        default:
//            break
//
//        }
        
        aboutView.backgroundColor  = UIColor(named: "cellColour")
        textLb.textColor = UIColor(named: "textColor")
        aboutView.layer.cornerRadius = 10
        aboutView.layer.borderColor = UIColor.lightGray.cgColor
        aboutView.layer.borderWidth = 0.1
        aboutView.layer.shadowColor = UIColor.black.withAlphaComponent(0.16).cgColor
        aboutView.layer.shadowRadius = 10
        aboutView.layer.shadowOffset = CGSize(width: 0, height: 1)
        aboutView.layer.shadowRadius = 3
        aboutView.layer.shadowOpacity = 1
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
