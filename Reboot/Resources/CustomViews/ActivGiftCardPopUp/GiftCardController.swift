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
    @IBOutlet weak var contentViewConst: NSLayoutConstraint!
    @IBOutlet weak var addGiftCard: AddGiftCardView!
    @IBOutlet weak var promoCodeView: PromoCodeView!
    private var bottomInset: CGFloat = 0
    //MARK: - LifeCycle
    var isPromoCodeController = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func keyboardHandler(_ contentInset: UIEdgeInsets) {
        contentViewConst.constant = contentInset.bottom
        bottomInset = contentInset.bottom
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
    }
}

extension GiftCardController {
    private func setupView() {
        promoCodeView.alpha = 0
        promoCodeView.isHidden = true
        addGiftCard.nextBtn.addTarget(self, action: #selector(showPromoCode), for: .touchUpInside)
        promoCodeView.saveBtn.addTarget(self, action: #selector(saveBtnAction), for: .touchUpInside)
    }
    
    @objc private func saveBtnAction() {
        dismiss(animated: true, completion: nil)
    }
}

extension GiftCardController {
   @objc func showPromoCode() {
        isPromoCodeController = true
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
        addGiftCard.isHidden = true
        promoCodeView.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionFlipFromLeft, animations: {
            self.addGiftCard.alpha = 0
            self.promoCodeView.alpha = 1
        }) { _ in }
    }
}

extension GiftCardController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }
    var longFormHeight: PanModalHeight {
        if isPromoCodeController {
            return .contentHeight(182 + bottomInset)
        } else {
            return .contentHeight(300 + bottomInset)
        }
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
