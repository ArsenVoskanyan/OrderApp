//
//  NetworkController.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 06.02.22.
//

import Foundation

final class NetworkController {
    static let shared = NetworkController()
    private init() {}

    func sendRequest<Request: APIRequest>(_ request: Request) async throws -> Request.Response {        
        let(data, response) = try await URLSession.shared.data(for: request.urlRequest)
        let errorName = String(describing: Request.self)
        let error = APIRequestErrors(rawValue: errorName)

        guard let httpResponse = response as? HTTPURLResponse,
              (200 ... 299).contains(httpResponse.statusCode)
        else { throw error ?? fatalError() }

        return try request.decodeResponse(data: data)
    }
}
