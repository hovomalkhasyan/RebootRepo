//
//  CustomPopUp.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 15.03.21.
//

import UIKit

class CustomPopUp: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func okAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
}

enum PopUpType: CaseIterable {
    case cancel
    case confirm
}
