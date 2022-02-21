//
//  MenuItemDetailViewController.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 01.02.22.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    var menuItem: MenuItem?

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var detailTextLabel: UILabel!
    @IBOutlet private weak var addToOrderButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        addCancelBarButtonItem()
        updateUI()
    }

    private func addCancelBarButtonItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonTapped(_:))
        )
    }

    @objc
    private func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    private func updateUI() {
        if let menuItem = menuItem {
            nameLabel.text = menuItem.name
            priceLabel.text = menuItem.price.formatted(.currency(code: "usd"))
            detailTextLabel.text = menuItem.detailText

            Task {
                if let image = try? await NetworkController.shared.sendRequest(ImageRequest(url: menuItem.imageURL)) {
                    imageView.image = image
                }
            }
        }
    }

    private func animatedOrderButton() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.1,
            options: []
        ) {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }

    @IBAction func orderButtonTapped(_ sender: UIButton) {
        animatedOrderButton()
        let orderController = OrderController.shared

        if let menuItem = menuItem,
           !orderController.order.menuItems.contains(menuItem) {
            orderController.order.menuItems.append( menuItem )
        }

        self.dismiss(animated: true)
    }
}
