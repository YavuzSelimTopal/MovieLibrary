//
//  HomeDTO.swift
//  MovieLibrary
//
//  Created by MACim on 30.05.2025.
//

import Foundation

struct MovieResponseDTO: Decodable {
    let page: Int
    let results: [MovieDTO]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieDTO: Decodable {
    let id: Int
    let title: String
    let originalTitle: String
    let posterPath: String?
    let backdropPath: String?
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let genreIds: [Int]
    let originalLanguage: String
    let video: Bool
    let adult: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case video
        case adult
    }
}
