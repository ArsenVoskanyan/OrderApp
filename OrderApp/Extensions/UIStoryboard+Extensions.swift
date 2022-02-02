//
//  UIStoryboard+Extensions.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 03.02.22.
//

import Foundation
import UIKit

extension UIStoryboard {
    static let main = UIStoryboard(name: "Main")
    static let menu = UIStoryboard(name: "Menu")
    static let order = UIStoryboard(name: "Orde")

    convenience init(name: String) {
        self.init(name: name, bundle: nil)
    }
}

extension UIStoryboard {
    func getInstance<Controller: UIViewController>(
        ofType controllerType: Controller.Type = Controller.self
    ) -> Controller {
        let reuseIdentifier = String(describing: controllerType)

        guard let viewController = self.instantiateViewController(withIdentifier: reuseIdentifier) as? Controller
        else { fatalError("View Controller init issue") }

        return viewController
    }
}
