//
//  HomeRouter.swift
//  MovieLibrary
//
//  Created by MACim on 28.05.2025.
//

import Foundation


enum HomeRouter: Endpoint {
    
    case getAction //
    case getComedy
    case getPopular
    case getThisYear
    
    var path: String {
        switch self {
        case .getAction, .getComedy, .getThisYear:
                return "/discover/movie"
        case .getPopular:
                return "/movie/popular"
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
            let genre = URLQueryItem(name: "with_genres", value: "28")
            return [apiKey, language, sortBy, genre]

        case .getComedy:
            let genre = URLQueryItem(name: "with_genres", value: "35")
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

//MARK: - Popular           https://api.themoviedb.org/3/movie/popular?api_key=0973a9edb0e6263a0644cdc44a81abc9&language=tr-TR

//MARK: - Action https://api.themoviedb.org/3/discover/movie?api_key=0973a9edb0e6263a0644cdc44a81abc9&language=tr-TR&sort_by=popularity.desc&with_genres=28

//MARK: - Comedy https://api.themoviedb.org/3/discover/movie?api_key=0973a9edb0e6263a0644cdc44a81abc9&language=tr-TR&sort_by=popularity.desc&with_genres=35

//MARK: - ThisYear https://api.themoviedb.org/3/discover/movie?api_key=0973a9edb0e6263a0644cdc44a81abc9&language=tr-TR&sort_by=popularity.desc&primary_release_year=2025
