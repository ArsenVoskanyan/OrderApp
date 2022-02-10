//
//  CategoryTableViewCell.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 10.02.22.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryNameLabel: UILabel!

    func populate(categoryName: String) {
        var content = self.defaultContentConfiguration()
        content.text = categoryName
        self.contentConfiguration = content
    }
}
