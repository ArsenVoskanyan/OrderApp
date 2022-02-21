//
//  HistoryOrdersTableViewController.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 21.02.22.
//

import UIKit

class HistoryOrdersTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addObserverNotificationCenter()
    }

    func addObserverNotificationCenter() {
        NotificationCenter().addObserver(
            self, selector: #selector(tableView.reloadData),
            name: OrderController.historyOrderUpdatedNotification,
            object: nil
        )
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        OrderController.shared.historyOrders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(for: indexPath)
        let historyOrder = OrderController.shared.historyOrders[indexPath.row]
        cell.textLabel?.text = OrderController.shared.historyOrders[indexPath.row].id
        cell.detailTextLabel?.text = historyOrder.price.formatted(.currency(code: "usd"))

        return cell
    }

}
