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
    case getNowPlaying
    case getAnimation
    case getAllMovies
    case search(query: String)
    
    var path: String {
        switch self {
        case .getAction, .getComedy, .getAnimation, .getAllMovies:
            return "discover/movie"
        case .getPopular:
            return "movie/popular"
        case .getNowPlaying:
            return "movie/now_playing"
        case .search:
            return "search/movie"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .getAction, .getComedy, .getPopular, .getNowPlaying, .getAnimation, .getAllMovies, .search:
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
        case .getNowPlaying:
            return [apiKey, language]
        case .getAnimation:
            let genre = URLQueryItem(name: "with_genres", value: "16")
            return [apiKey, language, sortBy, genre]
        case .getAllMovies:
            return [apiKey, language, sortBy]
        case .search(let query):
            let queryItem = URLQueryItem(name: "query", value: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            return [apiKey, language, queryItem]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .getAction, .getComedy, .getPopular, .getNowPlaying, .getAnimation, .getAllMovies, .search:
            return nil
        }
    }
}


//MARK: - Popular           https://api.themoviedb.org/3/movie/popular?api_key=0973a9edb0e6263a0644cdc44a81abc9&language=tr-TR

//MARK: - Action https://api.themoviedb.org/3/discover/movie?api_key=0973a9edb0e6263a0644cdc44a81abc9&language=tr-TR&sort_by=popularity.desc&with_genres=28

//MARK: - Comedy https://api.themoviedb.org/3/discover/movie?api_key=0973a9edb0e6263a0644cdc44a81abc9&language=tr-TR&sort_by=popularity.desc&with_genres=35

//MARK: - ThisYear https://api.themoviedb.org/3/discover/movie?api_key=0973a9edb0e6263a0644cdc44a81abc9&language=tr-TR&sort_by=popularity.desc&primary_release_year=2025

//MARK: - Now Playing (Vitrin) https://api.themoviedb.org/3/movie/now_playing?api_key=YOUR_API_KEY&language=tr-TR&page=1

//MARK: - Animation https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&language=tr-TR&sort_by=popularity.desc&with_genres=16
