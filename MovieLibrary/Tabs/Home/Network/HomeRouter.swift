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
    
    
    
    var path: String {
        switch self {
        case .getAction, .getComedy, .getAnimation:
            return "discover/movie"
        case .getPopular:
            return "movie/popular"
        case .getNowPlaying:
            return "movie/now_playing"
        
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .getAction, .getComedy, .getPopular, .getNowPlaying, .getAnimation:
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
        
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .getAction, .getComedy, .getPopular, .getNowPlaying, .getAnimation:
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
