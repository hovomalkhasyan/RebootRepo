//
//  PromoCodeController.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 15.03.21.
//

import UIKit
import PanModal

class PromoCodeController: BaseViewController {

    @IBOutlet weak var bottomConsst: NSLayoutConstraint!
    @IBOutlet weak var promoCodeView: PromoCodeView!
    private var bottomInset: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func keyboardHandler(_ contentInset: UIEdgeInsets) {
        bottomConsst.constant = -contentInset.bottom
        bottomInset = contentInset.bottom
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
    }
}


extension PromoCodeController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }
    var longFormHeight: PanModalHeight {
        return .contentHeight(182 + bottomInset)
    }
    var cornerRadius: CGFloat {
        return 10
    }
    var showDragIndicator: Bool {
        return false
    }
    
    func willTransition(to state: PanModalPresentationController.PresentationState) {
        guard case .longForm = state
            else { return }
        panModalSetNeedsLayoutUpdate()
    }
}
