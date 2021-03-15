//
//  AddGiftCardView.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 15.03.21.
//

import UIKit

class AddGiftCardView: UIView {
    
    //MARK: - IBOutlets
    @IBOutlet weak var cardNumberTf: TextField!
    @IBOutlet weak var pinTf: TextField!
    @IBOutlet weak var sumTf: TextField!
    @IBOutlet weak var textFieldStack: UIStackView!
    @IBOutlet weak var nextBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStackView()
        setDelegate()
    }

    @IBAction func nextBtnAction(_ sender: UIButton) {
        
    }
    
}

//MARK: - Extension
extension AddGiftCardView {
    private func setDelegate() {
        cardNumberTf.delegate = self
        pinTf.delegate = self
        sumTf.delegate = self
    }
    
   private func setupStackView() {
        let color = UIColor(named: "borderColor")
        for sub in textFieldStack.subviews {
            sub.layer.cornerRadius = 10
            sub.layer.borderWidth = 1
            guard let borderColor = color else {return}
            sub.layer.borderColor = borderColor.cgColor
        }
    }
}

extension AddGiftCardView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case cardNumberTf:
            pinTf.becomeFirstResponder()
        case pinTf:
            sumTf.becomeFirstResponder()
        case sumTf:
            endEditing(true)
        default:
            break
        }
        return true
    }
}
