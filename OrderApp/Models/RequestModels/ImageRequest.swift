//
//  ImageRequest.swift
//  OrderApp
//
//  Created by Arsen Voskanyan on 19.02.22.
//

import Foundation
import UIKit

struct ImageRequest: APIRequest {
    typealias Response = UIImage
    let url: URL

    var urlRequest: URLRequest {
        URLRequest(url: url)
    }

    func decodeResponse(data: Data) throws -> Response {
        guard let image = UIImage(data: data)
        else { throw APIRequestErrors.imageDataMissing }

        return image
    }
}
