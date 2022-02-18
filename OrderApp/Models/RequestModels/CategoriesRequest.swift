//
//  CategoriesRequest.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 06.02.22.
//

import Foundation

struct CategoriesRequest: APIRequest {
    typealias Response = [String]

    var urlRequest: URLRequest {
        let categoriesURL = baseURl.appendingPathComponent(APIFollowingEndpoints.categories.rawValue)
        return URLRequest(url: categoriesURL)
    }

    func decodeResponse(data: Data) throws -> Response {
        let decoder = JSONDecoder()
        let categoriesResponse = try decoder.decode(CategoriesResponse.self, from: data)
        return categoriesResponse.categories
    }
}
