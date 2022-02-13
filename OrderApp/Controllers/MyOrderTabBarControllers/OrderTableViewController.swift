//
//  OrderTableViewController.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 01.02.22.
//

import UIKit

class OrderTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            tableView!,
            selector: #selector(tableView.reloadData),
            name: NetworkController.orderUpdatedNotification,
            object: nil
        )
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NetworkController.shared.order.menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = NetworkController.shared.order
        let menuItem = order.menuItems[indexPath.row]
        let cell: OrderAndMenuItemTableViewCell = tableView.dequeue(for: indexPath)
        cell.populate(menuItem: menuItem)

        return cell
    }
}
