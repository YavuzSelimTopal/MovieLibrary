//
//  HomeDTO.swift
//  MovieLibrary
//
//  Created by MACim on 30.05.2025.
//

import Foundation

// API'den dönen yanıtın tamamını karşılar
struct MovieResponseDTO: Decodable {
    let results: [MovieDTO]
}

// Tek bir film nesnesini temsil eder
struct MovieDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double

}
