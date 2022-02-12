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
            action: #selector(cancelButtonFunctionality(_:))
        )
    }

    @objc
    func cancelButtonFunctionality(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    func updateUI() {
        if let menuItem = menuItem {
            nameLabel.text = menuItem.name
            priceLabel.text = menuItem.price.formatted(.currency(code: "usd"))
            detailTextLabel.text = menuItem.detailText
        }
    }
}
