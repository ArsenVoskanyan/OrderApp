//
//  OrderTableViewCell.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 18.02.22.
//

import UIKit

protocol OrderTableViewCellDelegate: AnyObject {
    func didTapOrderStepper(cell: UITableViewCell, stepper value: Int)
}

class OrderTableViewCell: UITableViewCell {
    weak var delegate: OrderTableViewCellDelegate?

    var orderItemName: String? { didSet {
        orderItemNameLabel.text = orderItemName
    }}

    var orderItemPrice: String? { didSet {
        orderItemPriceLabel.text = orderItemPrice
    }}

    @IBOutlet weak private var orderItemNameLabel: UILabel!
    @IBOutlet weak private var orderItemPriceLabel: UILabel!
    @IBOutlet weak private var totalOrderItemLabel: UILabel!
    @IBOutlet weak private var orderItemStepper: UIStepper!

    override func awakeFromNib() {
        super.awakeFromNib()

        totalOrderItemLabel.text = String(Int(orderItemStepper.value))
    }

    func populate(menuItem: MenuItem) {
        orderItemName = menuItem.name
        orderItemPrice = "$\(menuItem.price)"
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        totalOrderItemLabel.text = String(Int(orderItemStepper.value))

        delegate?.didTapOrderStepper(cell: self, stepper: Int(orderItemStepper.value - 1))
    }
}
