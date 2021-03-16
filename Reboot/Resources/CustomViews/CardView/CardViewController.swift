//
//  CardViewController.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 16.03.21.
//

import UIKit
import PanModal
class CardViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    public var selectedIndex: Int?
    //MARK: - Propertys
    var footerHeight: CGFloat = 180
    var headerHeight: CGFloat = 75
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
    }
}

extension CardViewController {
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.name, for: indexPath) as! CardTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: HeaderViewCell.name) as! HeaderViewCell
        return header
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableCell(withIdentifier: FooterViewCell.name) as! FooterViewCell
        footer.addCardDelegate = self
        return footer
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
}

extension CardViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return tableView
    }

    var anchorModalToLongForm: Bool {
        return false
    }

    var cornerRadius: CGFloat {
        return 10
    }
    var showDragIndicator: Bool {
        return false
    }
}

extension CardViewController: AddCreditCardDelegate {
    func addCard() {
        let controller = AddCardViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.paymentDelegate = self
        self.present(controller, animated: true, completion: nil)
    }
}

extension CardViewController: PaymentDelegate {
    func paymentSucced() {
        print("hello")
    }
    
    func paymentFailed() {
        print("hellos")
    }
    
    
}
