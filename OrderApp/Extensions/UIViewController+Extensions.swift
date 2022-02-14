//
//  UIViewController+Extensions.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 03.02.22.
//

import Foundation
import UIKit

extension UIViewController {
    static func getInstance(from storyboard: UIStoryboard) -> Self {
        guard let viewController = storyboard
            .instantiateViewController(withIdentifier: String(describing: Self.self)) as? Self
        else { fatalError("View Controller init issue") }

        return viewController
    }
}

extension UIViewController {
    func presentInNavigationController(_ viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }
}

extension UIViewController {
    func displayError(_ error: Error, _ title: String) {
        guard let _ = viewIfLoaded?.window
        else { return }

        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Dismiss", style: .default)
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
}
