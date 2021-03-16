//
//  GiftCardController.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 15.03.21.
//

import UIKit
import PanModal

class GiftCardController: BaseViewController {
    //NARK: - IBOutlets
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    @IBOutlet weak var addGiftCard: AddGiftCardView!
    private var bottomInset: CGFloat = 0
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func keyboardHandler(_ contentInset: UIEdgeInsets) {
        bottomConst.constant = -contentInset.bottom
        bottomInset = contentInset.bottom
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
    }
}

extension GiftCardController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }
    var longFormHeight: PanModalHeight {
        return .contentHeight(300 + bottomInset)
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
