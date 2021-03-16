//
//  SubscriptionsCell.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 16.03.21.
//

import UIKit

class SubscriptionsCell: UITableViewCell {

    @IBOutlet weak var planPrice: UILabel!
    @IBOutlet weak var planDescription: UILabel!
    @IBOutlet weak var planTitleLAbel: UILabel!
    @IBOutlet weak var subscriptionView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
}

extension SubscriptionsCell {
    private func setupView() {
        subscriptionView.layer.cornerRadius = 10
        subscriptionView.layer.borderColor = UIColor.gray.cgColor
        subscriptionView.layer.borderWidth = 0.3
        subscriptionView.layer.shadowOffset = CGSize(width: 0, height: 1)
        subscriptionView.layer.shadowOpacity = 0.5
        subscriptionView.layer.shadowRadius = 3
    }
}

extension SubscriptionsCell {
    func setData(model: PlansList) {
        self.planPrice.text = "\(model.price) ₽"
        self.planTitleLAbel.text = model.title
    }
}
