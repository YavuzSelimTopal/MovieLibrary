//
//  HomeView.swift
//  MovieLibrary
//
//  Created by MACim on 28.05.2025.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel: HomeViewModel

    init() {
        let movieService = MovieService(requestProcessor: RequestProcessor())
        _viewModel = StateObject(wrappedValue: HomeViewModel(movieService: movieService))
    }

    @State var selectedTab: Int = 0

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.circle")
                        Text("Profile")
                    }
                    .tag(1)

                ZStack {
                    ScrollView {
                        VStack(spacing: 20) {
                            CategorySectionView(title: "Popüler Filmler", movies: viewModel.popularMovies)
                            CategorySectionView(title: "Bu Yıl Çıkanlar", movies: viewModel.thisYearMovies)
                            CategorySectionView(title: "Aksiyon", movies: viewModel.actionMovies)
                            CategorySectionView(title: "Komedi", movies: viewModel.comedyMovies)
                        }
                        .padding()
                    }
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)

                MovieSearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass.circle.fill")
                        Text("Search")
                    }
                    .tag(2)
            }
            .task {
                await viewModel.fetchAllMovies()
            }
        }
    }
}

struct CategorySectionView: View {
    let title: String
    let movies: [MovieModel]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(movies) { movie in
                        HomeMovieCell(movie: movie)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
