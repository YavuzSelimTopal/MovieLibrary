//
//  CategoriesSectionViewModel.swift
//  MovieLibrary
//
//  Created by MACim on 20.06.2025.
//


import Foundation

final class CategoriesSectionViewModel: ObservableObject {
    private let movieService: MovieServiceProtocol
    let onMovieTap: (MovieModel) -> Void
    
    @Published var movieType: MovieTypes?
    @Published var movies: [MovieModel] = []
    
    init(
        movieService: MovieServiceProtocol,
        movieType: MovieTypes,
        onMovieTap: @escaping (MovieModel) -> Void
    ) {
        self.movieService = movieService
        self.movieType = movieType
        self.onMovieTap = onMovieTap
    }
    
    func fetchMovies() async {
        do {
            guard let movieType = movieType else { return }
            let movies: [MovieModel]
            switch movieType {
            case .popularMovies:
                movies = try await movieService.getPopularMovies(page: 1)
            case .actionMovies:
                movies = try await movieService.getActionMovies(page: 1)
            case .thisYear:
                movies = try await movieService.getThisYearMovies(page: 1)
            case .comedy:
                movies = try await movieService.getComedyMovies(page: 1)
            case .animation:
                movies = try await movieService.getAnimationMovies(page: 1)
            
            }
            DispatchQueue.main.async {
                self.movies = movies
            }
        } catch {
            print("Error fetching movies: \(error.localizedDescription)")
        }
    }
    
}

extension CategoriesSectionViewModel {
    enum MovieTypes {
        case popularMovies
        case actionMovies
        case thisYear
        case comedy
        case animation
        var title: String {
            switch self {
            case .popularMovies:
                return "Popular Movies"
            case .actionMovies:
                return "Action Movies"
            case .thisYear:
                return "This Year"
            case .comedy:
                return "Comedy"
            case .animation:
                return "Animation"
            }
        }
    }
}
