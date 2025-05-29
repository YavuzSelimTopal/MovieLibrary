//
//  HomeModel.swift
//  MovieLibrary
//
//  Created by MACim on 30.05.2025.
//

import Foundation

import Foundation

struct MovieModel: Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterURL: URL?
    let releaseDate: String
    let voteAverage: Double

    init(dto: MovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.overview = dto.overview
        self.posterURL = {
            if let path = dto.posterPath {
                return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            } else {
                return nil
            }
        }()
        self.releaseDate = dto.releaseDate ?? "Bilinmiyor"
        self.voteAverage = dto.voteAverage
    }
}
