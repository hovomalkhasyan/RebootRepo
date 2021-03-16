//
//  FooterViewCell.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 16.03.21.
//

import UIKit

protocol AddCreditCardDelegate: class {
    func addCard()
}

class FooterViewCell: UITableViewCell {
    
    weak var addCardDelegate: AddCreditCardDelegate?
    @IBOutlet weak var addCard: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
}

extension FooterViewCell {
    private func setup() {
        let gest = UITapGestureRecognizer(target: self, action: #selector(addCardAction))
        addCard.addGestureRecognizer(gest)
    }
    @objc private func addCardAction() {
        addCardDelegate?.addCard()
    }
    
}
