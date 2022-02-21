//
//  OrderTableViewController.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 01.02.22.
//

import UIKit

class OrderTableViewController: UITableViewController {
    private var minutesToPrepareOrder = 0
    private var menuItems = [MenuItem]()
    private var orderPrice = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        addObserverNotificationCenter()
        navigationItem.leftBarButtonItem = editButtonItem
    }

    func addObserverNotificationCenter() {
        NotificationCenter.default.addObserver(
            tableView!,
            selector: #selector(tableView.reloadData),
            name: OrderController.orderUpdatedNotification,
            object: nil
        )
    }

    @IBAction func submitTapped(_ sender: UIBarButtonItem) {
        menuItems += OrderController.shared.order.menuItems
        let orderTotalPrice = menuItems.reduce(0.0) { result, menuItem in
            return result + menuItem.price
        }
        let formattedTotal = orderTotalPrice.formatted(.currency(code: "usd"))
        let alertController = UIAlertController(
            title: "Confirm Order",
            message: "You are about to submit your order with a total of \(formattedTotal)",
            preferredStyle: .actionSheet
        )

        alertController.addAction(UIAlertAction(
            title: "Submit",
            style: .default,
            handler: { _ in
                self.uploadOrder(price: orderTotalPrice)

            }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }

    private func uploadOrder(price: Double) {
        let menuIds = menuItems.map { $0.id }

        Task {
            do {
                let historyOrder = HistoryOrder(order: Order(menuItems: menuItems), price: price)
                OrderController.shared.historyOrders.append(historyOrder)
                minutesToPrepareOrder = try await NetworkController.shared.sendRequest(OrderRequest(menuIDs: menuIds))
                presentOrderConfirmationVC(minutesToPrepare: minutesToPrepareOrder)
            } catch {
                displayError(error, "Order Submission Failed")
            }
        }
    }

    private func presentOrderConfirmationVC(minutesToPrepare: Int) {
        let storyboard = UIStoryboard.order
        let orderConfirmationVC: OrderConfirmationViewController = storyboard.getInstance()
        orderConfirmationVC.minutesToPrepare = minutesToPrepare
        present(orderConfirmationVC, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        OrderController.shared.order.menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = OrderController.shared.order
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
            OrderController.shared.order.menuItems.remove(at: indexPath.row)
        }
    }
}

extension OrderTableViewController: OrderTableViewCellDelegate {
    func didTapOrderStepper(cell: UITableViewCell, stepper value: Int) {
        if let index = tableView.indexPath(for: cell)?.row {
            let menuItem = OrderController.shared.order.menuItems[index]
            menuItems += Array(repeating: menuItem, count: value)
            orderPrice += menuItem.price * Double(value)
        }
    }
}
