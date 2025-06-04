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

        // Configure UITabBar with a default background and blur effect
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
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
                    Color.black.ignoresSafeArea()
                    ScrollView {
                        VStack(spacing: 20) {
                            
                            CategorySectionView(
                                title: "Popüler Filmler",
                                movies: viewModel.popularMovies,
                                loadMore: {
                                    Task {
                                        await viewModel.fetchPopularMovies()
                                    }
                                }
                            )
                            
                            CategorySectionView(
                                title: "Bu Yıl Çıkanlar",
                                movies: viewModel.thisYearMovies,
                                loadMore: {
                                    Task {
                                        await viewModel.fetchThisYearMovies()
                                    }
                                }
                            )
                            
                            CategorySectionView(
                                title: "Aksiyon",
                                movies: viewModel.actionMovies,
                                loadMore: {
                                    Task {
                                        await viewModel.fetchActionMovies()
                                    }
                                }
                            )
                            
                            CategorySectionView(
                                title: "Komedi",
                                movies: viewModel.comedyMovies,
                                loadMore: {
                                    Task {
                                        await viewModel.fetchComedyMovies()
                                    }
                                }
                            )
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
            .tint(.white)
        }
    }
}

struct CategorySectionView: View {
    let title: String
    let movies: [MovieModel]
    let loadMore: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.headline)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(movies.indices, id: \.self) { index in
                        HomeMovieCell(movie: movies[index])
                            .onAppear {
                                if index == movies.count - 1 {
                                    loadMore()
                                }
                            }
                    }
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
