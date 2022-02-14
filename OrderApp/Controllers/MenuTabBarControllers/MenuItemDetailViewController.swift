//
//  MenuItemDetailViewController.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 01.02.22.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    var menuItem: MenuItem?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        addCancelBarButtonItem()
        updateUI()
    }

    func addCancelBarButtonItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonTapped(_:))
        )
    }

    @objc
    func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    func updateUI() {
        if let menuItem = menuItem {
            nameLabel.text = menuItem.name
            priceLabel.text = menuItem.price.formatted(.currency(code: "usd"))
            detailTextLabel.text = menuItem.detailText
        }
    }

    func animatedOrderButton() {
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

        if let menuItem = menuItem {
            self.dismiss(animated: true) {
                NetworkController.shared.order.menuItems.append( menuItem )
            }
        }
    }
}
