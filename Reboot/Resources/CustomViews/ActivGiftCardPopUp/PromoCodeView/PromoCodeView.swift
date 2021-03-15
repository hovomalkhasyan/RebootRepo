//
//  PromoCodeView.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 15.03.21.
//

import UIKit

class PromoCodeView: UIView {
   //MARK: - IBOutlets
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var promoCodeTf: TextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextField()
    }

}

extension PromoCodeView {
    private func setupTextField() {
        let color = UIColor(named: "borderColor")
        promoCodeTf.layer.cornerRadius = 10
        promoCodeTf.layer.borderWidth = 1
            guard let borderColor = color else {return}
        promoCodeTf.layer.borderColor = borderColor.cgColor
    }
}
