//
//  HomeRouter.swift
//  MovieLibrary
//
//  Created by MACim on 28.05.2025.
//

import Foundation


enum HomeRouter: Endpoint {
    
    case getAction(page: Int)
    case getComedy(page: Int)
    case getPopular(page: Int)
    case getThisYear(page: Int)
    
    var path: String {
        switch self {
        case .getAction, .getComedy, .getThisYear:
            return "discover/movie"
        case .getPopular:
            return "movie/popular"
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
        var pageItem: URLQueryItem
        
        switch self {
        case .getAction(let page):
            pageItem = URLQueryItem(name: "page", value: "\(page)")
            let genre = URLQueryItem(name: "with_genres", value: "28")
            return [apiKey, language, sortBy, genre, pageItem]
        case .getComedy(let page):
            pageItem = URLQueryItem(name: "page", value: "\(page)")
            let genre = URLQueryItem(name: "with_genres", value: "35")
            return [apiKey, language, sortBy, genre, pageItem]
        case .getPopular(let page):
            pageItem = URLQueryItem(name: "page", value: "\(page)")
            return [apiKey, language, pageItem]
        case .getThisYear(let page):
            pageItem = URLQueryItem(name: "page", value: "\(page)")
            let year = String(Calendar.current.component(.year, from: Date()))
            let releaseYear = URLQueryItem(name: "primary_release_year", value: year)
            return [apiKey, language, sortBy, releaseYear, pageItem]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .getAction, .getComedy, .getPopular, .getThisYear:
            return nil
        }
    }
}


//MARK: - Popular           https://api.themoviedb.org/3/movie/popular?api_key=0973a9edb0e6263a0644cdc44a81abc9&language=tr-TR

//MARK: - Action https://api.themoviedb.org/3/discover/movie?api_key=0973a9edb0e6263a0644cdc44a81abc9&language=tr-TR&sort_by=popularity.desc&with_genres=28

//MARK: - Comedy https://api.themoviedb.org/3/discover/movie?api_key=0973a9edb0e6263a0644cdc44a81abc9&language=tr-TR&sort_by=popularity.desc&with_genres=35

//MARK: - ThisYear https://api.themoviedb.org/3/discover/movie?api_key=0973a9edb0e6263a0644cdc44a81abc9&language=tr-TR&sort_by=popularity.desc&primary_release_year=2025
