//
//  MenuItemTableViewCell.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 10.02.22.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {
    @IBOutlet weak var menuItemNameLabel: UILabel!
    @IBOutlet weak var menuItemPriceLabel: UILabel!

    func populate(menuItem: MenuItem) {
        menuItemNameLabel.text = menuItem.name
        menuItemPriceLabel.text = "$\(menuItem.price)"
    }
}
