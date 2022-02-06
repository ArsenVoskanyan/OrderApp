//
//  CategoryTableViewController.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 01.02.22.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(for: indexPath)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuTableViewController: MenuTableViewController = UIStoryboard.menu.getInstance()

        navigationController?.pushViewController(menuTableViewController, animated: true)
    }
}
