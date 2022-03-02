//
//  CategoryTableViewCell.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 10.02.22.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet private var categoryNameLabel: UILabel!

    func populate(categoryName: String) {
        categoryNameLabel.text = categoryName.capitalized
    }
}
