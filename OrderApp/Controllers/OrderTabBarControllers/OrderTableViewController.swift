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
        let allMenuItems = OrderController.shared.order.menuItems + menuItems
        let orderTotalPrice = allMenuItems.reduce(0.0) { result, menuItem in
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
            style: .default
        ) { _ in
            self.uploadOrder(price: orderTotalPrice)
        })

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alertController, animated: true)
    }

    private func uploadOrder(price: Double) {
        let allMenuItems = OrderController.shared.order.menuItems + menuItems
        let menuIds = allMenuItems.map(\.id)

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
        orderConfirmationVC.delegate = self
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
            menuItems = menuItems.filter { item in
                item != OrderController.shared.order.menuItems[indexPath.row]
            }
            OrderController.shared.order.menuItems.remove(at: indexPath.row)
        }
    }
}

extension OrderTableViewController: OrderTableViewCellDelegate {
    func didTapOrderStepper(cell: UITableViewCell, stepper value: Int) {
        if let index = tableView.indexPath(for: cell)?.row {
            menuItems = menuItems.filter { item in
                item != OrderController.shared.order.menuItems[index]
            }
            menuItems += Array(repeating: OrderController.shared.order.menuItems[index], count: value)
        }
    }
}

extension OrderTableViewController: OrderConfirmationViewControllerDelegate {
    func resetMenuItems() {
        OrderController.shared.order.menuItems.removeAll()
        menuItems.removeAll()
    }
}
