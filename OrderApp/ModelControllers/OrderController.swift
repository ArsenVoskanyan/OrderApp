//
//  OrderController.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 21.02.22.
//

import Foundation

final class OrderController {
    static let shared = OrderController()
    private init() {}

    var order = Order() { didSet {
        NotificationCenter.default.post(
            name: OrderController.orderUpdatedNotification,
            object: nil
        )
    }}

    var historyOrders = OrderController.historyOrders { didSet {
        OrderController.historyOrders = historyOrders
    }}

    static let historyOrdersURL: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let todosURL = urls.first
        else { fatalError() }

        return todosURL.appendingPathComponent("historyOrders").appendingPathExtension("plist")
    }()

    static var historyOrders: [HistoryOrder] {
        get {
            guard let data = try? Data(contentsOf: historyOrdersURL)
            else { return []}

            let historyOrders = try? PropertyListDecoder().decode([HistoryOrder].self, from: data)
            return historyOrders ?? []
        }

        set {
            guard let data = try? PropertyListEncoder().encode(newValue)
            else { return }

            try? data.write(to: historyOrdersURL)
        }
    }
}

extension OrderController {
    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    static let historyOrderUpdatedNotification = Notification.Name("MenuController.historyOrderUpdated")
}
