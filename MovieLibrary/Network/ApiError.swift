//
//  ApiError.swift
//  MovieLibrary
//
//  Created by MACim on 27.05.2025.
//

import Foundation

enum ApiError: Error {
    case invalidURL
    case encodingError
    case URLError
    case invalidResponse
    case decodingError
    case unknown
}
