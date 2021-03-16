//
//  PageButton.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 16.03.21.
//

import Foundation
import UIKit


class PageControlButton: UIButton {
    
    override var isSelected: Bool {
        willSet {
            backgroundColor = newValue ? .black : .clear
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout() {
        layer.cornerRadius = bounds.height/2
        layer.masksToBounds = true
    }
    
    func setup() {
        setTitleColor(.white, for: .selected)
        setTitleColor(.black, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout()
    }
}
