//
//  HomeRouter.swift
//  MovieLibrary
//
//  Created by MACim on 28.05.2025.
//

import Foundation


enum HomeRouter: Endpoint {
    
    case getAction
    case getComedy
    case getPopular
    case getThisYear
    
    var path: String {
        switch self {
        case .getAction: return "/discover/movie"
        case .getComedy: return "/discover/movie"
        case .getPopular: return "/movie/popular"
        case .getThisYear: return "/discover/movie"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .getAction, .getComedy, .getPopular, .getThisYear:
            return .get
            
        }
    }
    
    var queryItems: [URLQueryItem]? {
        let apiKey = URLQueryItem(name: "api_key", value: token)
        let language = URLQueryItem(name: "language", value: "tr-TR")
        let sortBy = URLQueryItem(name: "sort_by", value: "popularity.desc")
        
        switch self {
        case .getAction:
            let genre = URLQueryItem(name: "with_genres", value: "28") // Aksiyon id 28
            return [apiKey, language, sortBy, genre]
            
        case .getComedy:
            let genre = URLQueryItem(name: "with_genres", value: "35") // Komedi id 35
            return [apiKey, language, sortBy, genre]
            
        case .getPopular:
            return [apiKey, language]
            
        case .getThisYear:
            let year = String(Calendar.current.component(.year, from: Date()))
            let releaseYear = URLQueryItem(name: "primary_release_year", value: year)
            return [apiKey, language, sortBy, releaseYear]
        }
    }
    
    var body: [String : Any]? {
        switch self {
            
        case .getAction:
            return nil
        case .getComedy:
            return nil
        case .getPopular:
            return nil
        case .getThisYear:
            return nil
        }
    }
}
