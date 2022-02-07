//
//  APIRequest.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 06.02.22.
//

import Foundation

protocol APIRequest {
    associatedtype Response

    var baseURl: URL { get }
    var urlRequest: URLRequest { get }
    func decodeResponse(data: Data) throws -> Response
}

extension APIRequest {
    var baseURl: URL {
        guard let baseURL = URL(string: "http://localhost:8080/")
        else { fatalError() }

        return baseURL
    }
}
