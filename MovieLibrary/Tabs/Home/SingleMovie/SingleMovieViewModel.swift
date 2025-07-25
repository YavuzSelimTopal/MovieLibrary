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
                
                let movies = try await movieService.getNowPlayingMovies()

                if let randomMovie = movies.randomElement() {
                    
                        self.movie = randomMovie
                    
                }
            } catch {
                print("Error fetching random movie: \(error.localizedDescription)")
            }
        }
    }
}
