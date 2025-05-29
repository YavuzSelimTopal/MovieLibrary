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
        "https://api.themoviedb.org/3/"
    }
    
    var token: String? {
        "0973a9edb0e6263a0644cdc44a81abc9"
    }
}
