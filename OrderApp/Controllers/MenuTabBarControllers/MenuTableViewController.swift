//
//  MenuTableViewController.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 01.02.22.
//

import UIKit

class MenuTableViewController: UITableViewController {
    var category = ""
    private var menuItems = [MenuItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configTitle()
        updateUI()
    }

    private func configTitle() {
        self.title = "Menu"
        self.navigationItem.largeTitleDisplayMode = .never
    }

    private func updateUI() {
        Task.init {
            do {
                menuItems = try await NetworkController.shared.sendRequest(MenuItemsRequest(categoryName: category))
                tableView.reloadData()
            } catch {
                displayError(error, "Failed to Fetch Menu Items")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuItem = menuItems[indexPath.row]
        let cell: MenuItemTableViewCell = tableView.dequeue(for: indexPath)
        cell.populate(menuItem: menuItem)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuItemDetailViewController: MenuItemDetailViewController = UIStoryboard.menu.getInstance()
        menuItemDetailViewController.menuItem = menuItems[indexPath.row]
        presentInNavigationController(menuItemDetailViewController)
    }
}
