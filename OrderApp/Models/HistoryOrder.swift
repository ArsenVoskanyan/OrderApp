//
//  HistoryOrder.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 21.02.22.
//

import Foundation

struct HistoryOrder: Codable {
    let id: String
    let price: Double
    let order: Order

    init(order: Order, price: Double) {
        id = UUID().uuidString
        self.order = order
        self.price = price
    }
}
