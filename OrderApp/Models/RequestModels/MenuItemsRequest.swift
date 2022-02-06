//
//  MenuItemsRequest.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 06.02.22.
//

import Foundation

struct MenuItemsRequest: APIRequest {
    typealias Response = [MenuItem]

    let categoryName: String

    var urlRequest: URLRequest {
        let menuURL = baseURl.appendingPathComponent(APIFollowingEndpoints.menu.rawValue)
        let queries = ["category": categoryName]
        var components = URLComponents(url: menuURL, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components?.url
        else { fatalError() }

        return URLRequest(url: url)
    }
    
    func decodeResponse(data: Data) throws -> Response {

        let decoder = JSONDecoder()
        let menuResponse = try decoder.decode(MenuResponse.self, from: data)

        return menuResponse.items
    }
}
