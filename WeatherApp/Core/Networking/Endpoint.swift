//
//  Endpoint.swift
//  Instagram
//
//  Created by Oleksandr Melnechenko on 08.10.2025.
//

import Foundation

struct Endpoint<Response: Decodable>: Sendable {
    let path: String
    var method: HTTPMethod = .get
    var query: [URLQueryItem] = []
    var headers: [String: String] = [:]
    var body: AnyEncodable? = nil
    
    init(path: String) {
        self.path = path
    }
}
