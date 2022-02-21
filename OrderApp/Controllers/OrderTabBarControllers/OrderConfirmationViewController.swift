//
//  OrderConfirmationViewController.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 15.02.22.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    var minutesToPrepare = 0

    @IBOutlet weak var confirmationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        confirmationLabel.text = "Thank you for your order! Your wait time is approximately \(minutesToPrepare) minutes"
    }

    @IBAction func dissmisTapped() {
        dismiss(animated: true) {
            OrderController.shared.order.menuItems.removeAll()
        }
    }
}
