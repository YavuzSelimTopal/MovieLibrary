//
//  HomeView.swift
//  MovieLibrary
//
//  Created by MACim on 28.05.2025.
//

import SwiftUI



struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel //TODO: StateObject ile arasındaki farkı öğren
    @State private var selectedMovie: MovieModel?

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        
                        HStack {
                            SingleMovieView(
                                viewModel: SingleMovieViewModel(
                                    movieService: MovieService(requestProcessor: RequestProcessor()),
                                    onMovieTap: { movie in
                                        selectedMovie = movie
                                    })
                            )
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 8)
                        }
                        
                        CategorySectionView(
                            viewModel: CategoriesSectionViewModel(
                                movieService: MovieService(requestProcessor: RequestProcessor()),
                                movieType: .popularMovies,
                                onMovieTap: { movie in
                                    selectedMovie = movie
                                })
                        )

                        CategorySectionView(
                            viewModel: CategoriesSectionViewModel(
                                movieService: MovieService(requestProcessor: RequestProcessor()),
                                movieType: .thisYear,
                                onMovieTap: { movie in
                                    selectedMovie = movie
                                })
                        )

                        CategorySectionView(
                            viewModel: CategoriesSectionViewModel(
                                movieService: MovieService(requestProcessor: RequestProcessor()),
                                movieType: .actionMovies,
                                onMovieTap: { movie in
                                    selectedMovie = movie
                                })
                        )

                        CategorySectionView(
                            viewModel: CategoriesSectionViewModel(
                                movieService: MovieService(requestProcessor: RequestProcessor()),
                                movieType: .comedy,
                                onMovieTap: { movie in
                                    selectedMovie = movie
                                })
                        )
                    }
                    .padding()
                }
            }
            .navigationDestination(item: $selectedMovie) { movie in
                MovieDetailView(movie: movie)
            }
        }
    }
}

//ayır

#Preview {
    HomeView(
        viewModel: HomeViewModel(
            movieService: MovieService(requestProcessor: RequestProcessor())
        )
    )
}
