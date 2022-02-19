//
//  APIRequestErors.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 06.02.22.
//

import Foundation

enum APIRequestErrors: String, Error {
    case categoriesNotFound = "CategoriesRequest"
    case menuItemsNotFound = "MenuItemsRequest"
    case orderRequestFailed = "OrderRequest"
    case imageDataMissing = "ImageRequest"
}
