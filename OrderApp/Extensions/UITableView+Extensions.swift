//
//  UITableView+Extensions.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 03.02.22.
//

import Foundation
import UIKit

extension UITableView {
    func dequeue<T: UITableViewCell>(
        for indexPath: IndexPath,
        ofType cellType: T.Type = T.self
    ) -> T {
        let reuseIdentifier = String(describing: cellType.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? T
        else { fatalError("Check Cell reuseIdentifier") }
        return cell
    }
}
