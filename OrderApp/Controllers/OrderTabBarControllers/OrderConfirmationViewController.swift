//
//  OrderConfirmationViewController.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 15.02.22.
//

import UIKit

protocol OrderConfirmationViewControllerDelegate: AnyObject {
    func resetMenuItems()
}

class OrderConfirmationViewController: UIViewController {
    weak var delegate: OrderConfirmationViewControllerDelegate?
    var minutesToPrepare = 0

    @IBOutlet weak var confirmationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        confirmationLabel.text = "Thank you for your order! Your wait time is approximately \(minutesToPrepare) minutes"
    }

    @IBAction func dissmisTapped() {
        delegate?.resetMenuItems()
        dismiss(animated: true)
    }
}
