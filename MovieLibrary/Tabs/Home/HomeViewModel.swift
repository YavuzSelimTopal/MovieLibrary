//
//  HomeViewModel.swift
//  MovieLibrary
//
//  Created by MACim on 28.05.2025.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    private let movieService: MovieServiceProtocol

    // Farklı kategoriye göre filmler
    @Published var actionMovies: [MovieModel] = []
    private var actionCurrentPage = 1
    private var canLoadMoreAction = true

    @Published var comedyMovies: [MovieModel] = []
    private var comedyCurrentPage = 1
    private var canLoadMoreComedy = true

    @Published var popularMovies: [MovieModel] = []
    private var popularCurrentPage = 1
    private var canLoadMorePopular = true

    @Published var thisYearMovies: [MovieModel] = []
    private var thisYearCurrentPage = 1
    private var canLoadMoreThisYear = true

    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }

    func fetchActionMovies() async {
        guard canLoadMoreAction else { return }
        do {
            let movies = try await movieService.getActionMovies(page: actionCurrentPage)
            if movies.isEmpty {
                canLoadMoreAction = false
            } else {
                actionCurrentPage += 1
                actionMovies.append(contentsOf: movies)
            }
        } catch {
            print("Aksiyon filmleri hatası:", error.localizedDescription)
        }
    }

    func fetchComedyMovies() async {
        guard canLoadMoreComedy else { return }
        do {
            let movies = try await movieService.getComedyMovies(page: comedyCurrentPage)
            if movies.isEmpty {
                canLoadMoreComedy = false
            } else {
                comedyCurrentPage += 1
                comedyMovies.append(contentsOf: movies)
            }
        } catch {
            print("Komedi filmleri hatası:", error.localizedDescription)
        }
    }

    func fetchPopularMovies() async {
        guard canLoadMorePopular else { return }
        do {
            let movies = try await movieService.getPopularMovies(page: popularCurrentPage)
            if movies.isEmpty {
                canLoadMorePopular = false
            } else {
                popularCurrentPage += 1
                popularMovies.append(contentsOf: movies)
            }
        } catch {
            print("Popüler filmler hatası:", error.localizedDescription)
        }
    }

    func fetchThisYearMovies() async {
        guard canLoadMoreThisYear else { return }
        do {
            let movies = try await movieService.getThisYearMovies(page: thisYearCurrentPage)
            if movies.isEmpty {
                canLoadMoreThisYear = false
            } else {
                thisYearCurrentPage += 1
                thisYearMovies.append(contentsOf: movies)
            }
        } catch {
            print("Bu yıl çıkan filmler hatası:", error.localizedDescription)
        }
    }

    // Tümünü çağırmak için toplu fonksiyon (isteğe bağlı)
    func fetchAllMovies() async {
        async let action = fetchActionMovies()
        async let comedy = fetchComedyMovies()
        async let popular = fetchPopularMovies()
        async let thisYear = fetchThisYearMovies()

        _ = await (action, comedy, popular, thisYear)
    }
}
