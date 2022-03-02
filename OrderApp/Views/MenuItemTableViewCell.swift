//
//  OrderAndMenuItemTableViewCell.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 10.02.22.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {
    private var imageLoadTask: Task<Void, Never>?

    @IBOutlet private var menuItemImageView: UIImageView!
    @IBOutlet private var menuItemNameLabel: UILabel!
    @IBOutlet private var menuItemPriceLabel: UILabel!

    override func prepareForReuse() {
        menuItemNameLabel.text = nil
        menuItemPriceLabel.text = nil
        menuItemImageView.image = nil
        imageLoadTask = nil
    }

    func populate(menuItem: MenuItem) {
        menuItemNameLabel.text = menuItem.name
        menuItemPriceLabel.text = menuItem.price.formatted(.currency(code: "usd"))

        imageLoadTask = Task {
            if let image = try? await NetworkController.shared.sendRequest(ImageRequest(url: menuItem.imageURL)) {
                menuItemImageView.image = image
            }
        }
        imageLoadTask = nil
    }
}
