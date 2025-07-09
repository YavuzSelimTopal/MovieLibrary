//
//  SingleMovieViewModel.swift
//  MovieLibrary
//
//  Created by MACim on 30.06.2025.
//

import Foundation

@MainActor
final class SingleMovieViewModel: ObservableObject {
    
    private let movieService: MovieServiceProtocol
    let onMovieTap: (MovieModel) -> Void
    
    @Published var movie: MovieModel?
    @Published var Showcasetitle: String = "Showcase"

    init(
        movieService: MovieServiceProtocol,
        
        onMovieTap: @escaping (MovieModel) -> Void
    ) {
        self.movieService = movieService
        
        self.onMovieTap = onMovieTap
        fetchRandomMovie()
    }

    private func fetchRandomMovie() {
        Task {
            do {
                
                let movies: [MovieModel]
                let allPopular = try await movieService.getPopularMovies(page: 1)
                let allAction = try await movieService.getActionMovies(page: 1)
                let allThisYear = try await movieService.getThisYearMovies(page: 1)
                let allComedy = try await movieService.getComedyMovies(page: 1)

                movies = allPopular + allAction + allThisYear + allComedy

                if let randomMovie = movies.randomElement() {
                    
                        self.movie = randomMovie
                    
                }
            } catch {
                print("Error fetching random movie: \(error.localizedDescription)")
            }
        }
    }
}

