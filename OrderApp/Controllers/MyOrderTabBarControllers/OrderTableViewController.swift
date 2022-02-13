//
//  OrderTableViewController.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 01.02.22.
//

import UIKit

class OrderTableViewController: UITableViewController {
    var order = Order()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         order.menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuItem = order.menuItems[indexPath.row]
        let cell: OrderAndMenuItemTableViewCell = tableView.dequeue(for: indexPath)
        cell.populate(menuItem: menuItem)

        return cell
    }
}
