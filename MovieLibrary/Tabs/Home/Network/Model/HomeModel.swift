//
//  HomeModel.swift
//  MovieLibrary
//
//  Created by MACim on 30.05.2025.
//


import Foundation

struct MovieModel: Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterURL: URL?
    let backdropURL: URL?
    let releaseDate: String
    let voteAverage: Double
}

extension MovieModel {
    init(dto: MovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.overview = dto.overview
        self.releaseDate = dto.releaseDate
        self.voteAverage = dto.voteAverage
        self.posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(dto.posterPath ?? "")")
        self.backdropURL = URL(string: "https://image.tmdb.org/t/p/w780\(dto.backdropPath ?? "")")
    }
}
