//
//  EndPoint.swift
//  MovieLibrary
//
//  Created by MACim on 24.05.2025.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    var baseURL: String {
        "https://jsonplaceholder.typicode.com"
    }
    
    var token: String? {
        nil
    }
}
