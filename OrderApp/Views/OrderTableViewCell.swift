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
    private var imageLoadTask: Task<Void, Never>?
    private var price = 0.0

    @IBOutlet private weak var orderItemImageView: UIImageView!
    @IBOutlet private weak var orderItemNameLabel: UILabel!
    @IBOutlet private weak var orderItemPriceLabel: UILabel!
    @IBOutlet private weak var totalOrderItemLabel: UILabel!
    @IBOutlet private weak var orderItemStepper: UIStepper!

    override func awakeFromNib() {
        super.awakeFromNib()

        totalOrderItemLabel.text = String(Int(orderItemStepper.value))
    }

    override func prepareForReuse() {
        orderItemNameLabel.text = nil
        orderItemPriceLabel.text = nil
        orderItemImageView.image = nil
        imageLoadTask = nil
    }

    func populate(menuItem: MenuItem) {
        orderItemNameLabel.text = menuItem.name
        orderItemPriceLabel.text = menuItem.price.formatted(.currency(code: "usd"))
        price = menuItem.price

        imageLoadTask = Task {
            if let image = try? await NetworkController.shared.sendRequest(ImageRequest(url: menuItem.imageURL)) {
                orderItemImageView.image = image
            }
        }
        imageLoadTask = nil
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        totalOrderItemLabel.text = String(Int(orderItemStepper.value))
        orderItemPriceLabel.text = (price * orderItemStepper.value).formatted(.currency(code: "usd"))

        delegate?.didTapOrderStepper(cell: self, stepper: Int(orderItemStepper.value - 1))
    }
}
