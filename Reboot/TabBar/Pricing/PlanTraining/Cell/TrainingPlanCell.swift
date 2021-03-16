//
//  TrainingPlanCell.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 16.03.21.
//

import UIKit

class TrainingPlanCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TrainingPlanCell {
    private func viewSetup() {
        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.layer.borderWidth = 0.3
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 3
    }
}

extension TrainingPlanCell {
    func setData(model: PlansList) {
        
    }
}
