//
//  SearchRouter.swift
//  MovieLibrary
//
//  Created by MACim on 25.07.2025.
//

import Foundation

enum SearchRouter: Endpoint {
    
    case search(query: String)
    case getAllMovies
    
    
    var path : String {
        switch self {
        case .search:
            return "search/movie"
        case  .getAllMovies:
            return "discover/movie"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case  .search, .getAllMovies:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        let apiKey = URLQueryItem(name: "api_key", value: token)
        let language = URLQueryItem(name: "language", value: "tr-TR")
        let sortBy = URLQueryItem(name: "sort_by", value: "popularity.desc")
        
        switch self {
        case .search(let query):
            let queryItem = URLQueryItem(name: "query", value: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            return [apiKey, language, queryItem]
        case .getAllMovies:
            return [apiKey, language, sortBy]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .search, .getAllMovies:
            return nil
        }
    }
}




