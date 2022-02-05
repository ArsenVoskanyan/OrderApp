//
//  Order.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 03.02.22.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]

    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
