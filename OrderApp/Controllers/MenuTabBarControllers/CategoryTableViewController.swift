//
//  CategoryTableViewController.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 01.02.22.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    var categories = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    func updateUI() {
        Task {
            do {
                categories = try await NetworkController.shared.sendRequest(CategoriesRequest())
                tableView.reloadData()
            } catch {
                displayError(error, "Failed to Fetch Categories")
            }
        }
    }

    func displayError(_ error: Error, _ title: String) {
        guard let _ = viewIfLoaded?.window else { return }

        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Dismiss", style: .default)
        alert.addAction(alertAction)

        self.present(alert, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let category = categories[indexPath.row]
        let cell: CategoryTableViewCell = tableView.dequeue(for: indexPath)
        cell.populate(categoryName: category)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuTableViewController: MenuTableViewController = UIStoryboard.menu.getInstance()
        menuTableViewController.category = categories[indexPath.row]

        navigationController?.pushViewController(menuTableViewController, animated: true)
    }
}
