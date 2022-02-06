//
//  OrderRequest.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 06.02.22.
//

import Foundation

struct OrderRequest: APIRequest {
    typealias Response = Int

    let menuIDs: [Int]

    var urlRequest: URLRequest {
        let orderURL = baseURl.appendingPathComponent(APIFollowingEndpoints.order.rawValue)
        let menuIDsDict = ["menuIds": menuIDs]

        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(menuIDsDict)
        else { fatalError() }

        var urlRequest = URLRequest(url: orderURL)
        urlRequest.httpBody = jsonData
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return urlRequest
    }

    func decodeResponse(data: Data) throws -> Response {

        let decoder = JSONDecoder()
        let orderResponse = try decoder.decode(OrderResponse.self, from: data)

        return orderResponse.prepTime
    }
}
