//
//  Extension+UITableView.swift
//  Reboot
//
//  Created by Hovo Malkhasyan on 30.01.21.
//

import Foundation
import UIKit

extension UITableView {
    func registerCellFromXib(cell: UITableViewCell.Type) {
        self.register(UINib(nibName: cell.name, bundle: nil), forCellReuseIdentifier: cell.name)
    }
}
