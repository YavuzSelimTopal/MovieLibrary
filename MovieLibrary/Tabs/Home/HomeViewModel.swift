//
//  HomeViewModel.swift
//  MovieLibrary
//
//  Created by MACim on 28.05.2025.
//

import Foundation

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    private let movieService: MovieServiceProtocol

    // Farklı kategoriye göre filmler
    @Published var actionMovies: [MovieModel] = []
    @Published var comedyMovies: [MovieModel] = []
    @Published var popularMovies: [MovieModel] = []
    @Published var thisYearMovies: [MovieModel] = []

    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }

    func fetchActionMovies() async {
        do {
            let movies = try await movieService.getActionMovies()
            self.actionMovies = movies
        } catch {
            print("Aksiyon filmleri hatası:", error.localizedDescription)
        }
    }

    func fetchComedyMovies() async {
        do {
            let movies = try await movieService.getComedyMovies()
            self.comedyMovies = movies
        } catch {
            print("Komedi filmleri hatası:", error.localizedDescription)
        }
    }

    func fetchPopularMovies() async {
        do {
            let movies = try await movieService.getPopularMovies()
            self.popularMovies = movies
        } catch {
            print("Popüler filmler hatası:", error.localizedDescription)
        }
    }

    func fetchThisYearMovies() async {
        do {
            let movies = try await movieService.getThisYearMovies()
            self.thisYearMovies = movies
        } catch {
            print("Bu yıl çıkan filmler hatası:", error.localizedDescription)
        }
    }

    // Tümünü çağırmak için toplu fonksiyon (isteğe bağlı)
    func fetchAllMovies() async {
        async let action: () = fetchActionMovies()
        async let comedy: () = fetchComedyMovies()
        async let popular: () = fetchPopularMovies()
        async let thisYear: () = fetchThisYearMovies()

        // Hepsini aynı anda başlat
        _ = await (action, comedy, popular, thisYear)
    }
}
