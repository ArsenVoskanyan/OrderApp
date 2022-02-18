//
//  OrderAndMenuItemTableViewCell.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 10.02.22.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

    var menuItemName: String? { didSet {
        menuItemNameLabel.text = menuItemName
    }}

    var menuItemPrice: String? { didSet {
        menuItemPriceLabel.text = menuItemPrice
    }}

    @IBOutlet weak private var menuItemNameLabel: UILabel!
    @IBOutlet weak private var menuItemPriceLabel: UILabel!

    func populate(menuItem: MenuItem) {
        menuItemName = menuItem.name
        menuItemPrice = "$\(menuItem.price)"
    }
}
