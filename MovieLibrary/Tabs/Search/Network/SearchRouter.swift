//
//  SearchRouter.swift
//  MovieLibrary
//
//  Created by MACim on 25.07.2025.
//

import Foundation

enum SearchRouter: Endpoint {
    
    case search(query: String)
    
    
    var path : String {
        switch self {
        case .search:
            return "search/movie"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        let apiKey = URLQueryItem(name: "api_key", value: token)
        let language = URLQueryItem(name: "language", value: "tr-TR")
        
        switch self {
        case .search(let query):
            let queryItem = URLQueryItem(name: "query", value: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            return [apiKey, language, queryItem]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .search:
            return nil
        }
    }
}




