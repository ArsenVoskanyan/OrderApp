//
//  OrderTableViewController.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 01.02.22.
//

import UIKit

class OrderTableViewController: UITableViewController {
    var minutesToPrepareOrder = 0
    var menuIds = [Int]()
    var orderPrice = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        addObserverNotificationCenter()
        navigationItem.leftBarButtonItem = editButtonItem
    }

    func addObserverNotificationCenter() {
        NotificationCenter.default.addObserver(
            tableView!,
            selector: #selector(tableView.reloadData),
            name: NetworkController.orderUpdatedNotification,
            object: nil
        )
    }

    @IBAction func submitTapped(_ sender: UIBarButtonItem) {
        let orderTotal = NetworkController.shared.order.menuItems.reduce(orderPrice) { result, menuItem in
            return result + menuItem.price
        }
        let formattedTotal = orderTotal.formatted(.currency(code: "usd"))
        let alertController = UIAlertController(
            title: "Confirm Order",
            message: "You are about to submit your order with a total of \(formattedTotal)",
            preferredStyle: .actionSheet
        )

        alertController.addAction(UIAlertAction(
            title: "Submit",
            style: .default,
            handler: { _ in
                self.uploadOrder()

            }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }

    func uploadOrder() {
        menuIds += NetworkController.shared.order.menuItems.map { $0.id }

        Task {
            do {
                minutesToPrepareOrder = try await NetworkController.shared.sendRequest(OrderRequest(menuIDs: menuIds))
                presentOrderConfirmationVC(minutesToPrepare: minutesToPrepareOrder)
            } catch {
                displayError(error, "Order Submission Failed")
            }
        }
    }

    func presentOrderConfirmationVC(minutesToPrepare: Int) {
        let storyboard = UIStoryboard.order
        let orderConfirmationVC: OrderConfirmationViewController = storyboard.getInstance()
        orderConfirmationVC.minutesToPrepare = minutesToPrepare
        present(orderConfirmationVC, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NetworkController.shared.order.menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = NetworkController.shared.order
        let menuItem = order.menuItems[indexPath.row]
        let cell: OrderTableViewCell = tableView.dequeue(for: indexPath)
        cell.delegate = self
        cell.populate(menuItem: menuItem)

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            NetworkController.shared.order.menuItems.remove(at: indexPath.row)
        }
    }
}

extension OrderTableViewController: OrderTableViewCellDelegate {
    func didTapOrderStepper(cell: UITableViewCell, stepper value: Int) {
        if let index = tableView.indexPath(for: cell)?.row {
            let menuItem = NetworkController.shared.order.menuItems[index]
            menuIds += Array(repeating: menuItem.id, count: value)
            orderPrice += menuItem.price * Double(value)
        }
    }
}
