//
//  HomeView.swift
//  MovieLibrary
//
//  Created by MACim on 28.05.2025.
//

import SwiftUI

// Ana sayfa görünümü (Home ekranı)
struct HomeView: View {
    
    // ViewModel'i yönetmek için StateObject olarak tanımlıyoruz
    @StateObject private var viewModel: HomeViewModel
    
    // Detay sayfasına geçişte kullanılacak, seçilen film
    @State private var selectedMovie: MovieModel?

    // init içinde ViewModel'e bağlı servis kuruluyor ve UITabBar ayarlanıyor
    init() {
        let movieService = MovieService(requestProcessor: RequestProcessor())
        _viewModel = StateObject(wrappedValue: HomeViewModel(movieService: movieService))

        // Alt menü (tab bar) arka planı yapılandırılıyor
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    // TabView'da hangi sekmenin seçili olduğunu takip ediyoruz
    @State var selectedTab: Int = 0

    var body: some View {
        
        // NavigationStack, sayfalar arası geçişleri yönetir
        NavigationStack {
            
            // Seçilen film varsa MovieDetailView ekranına geçiş yapılır
            NavigationLink(
                destination: selectedMovie.map { MovieDetailView(movie: $0) },
                isActive: Binding(
                    get: { selectedMovie != nil },
                    set: { isActive in
                        if !isActive {
                            selectedMovie = nil // Geri dönüldüğünde seçim sıfırlanır
                        }
                    }
                )
            ) {
                EmptyView() // Görünmez bağlantı
            }
            .hidden() // UI'da gözükmesini engeller
            
            // Alt sekmeli yapı (Home, Profile, Search gibi)
            TabView(selection: $selectedTab) {
                
                // Profil sekmesi
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.circle")
                        Text("Profile")
                    }
                    .tag(1)

                // Ana içerik sekmesi
                ZStack {
                    Color.black.ignoresSafeArea() // Arka plan siyah
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            
                            // Popüler Filmler bölümü
                            CategorySectionView(
                                title: "Popüler Filmler",
                                movies: viewModel.popularMovies,
                                loadMore: {
                                    Task {
                                        await viewModel.fetchPopularMovies() // Sayfalı veri getirme
                                    }
                                },
                                onMovieTap: { movie in
                                    selectedMovie = movie // Filme tıklandığında detay ekranına git
                                }
                            )
                            
                            // Bu yıl çıkanlar bölümü
                            CategorySectionView(
                                title: "Bu Yıl Çıkanlar",
                                movies: viewModel.thisYearMovies,
                                loadMore: {
                                    Task {
                                        await viewModel.fetchThisYearMovies()
                                    }
                                },
                                onMovieTap: { movie in
                                    selectedMovie = movie
                                }
                            )
                            
                            // Aksiyon filmleri bölümü
                            CategorySectionView(
                                title: "Aksiyon",
                                movies: viewModel.actionMovies,
                                loadMore: {
                                    Task {
                                        await viewModel.fetchActionMovies()
                                    }
                                },
                                onMovieTap: { movie in
                                    selectedMovie = movie
                                }
                            )
                            
                            // Komedi filmleri bölümü
                            CategorySectionView(
                                title: "Komedi",
                                movies: viewModel.comedyMovies,
                                loadMore: {
                                    Task {
                                        await viewModel.fetchComedyMovies()
                                    }
                                },
                                onMovieTap: { movie in
                                    selectedMovie = movie
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

                // Arama sekmesi
                MovieSearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass.circle.fill")
                        Text("Search")
                    }
                    .tag(2)
            }
            // Uygulama açıldığında tüm film verileri çekilir
            .task {
                await viewModel.fetchAllMovies()
            }
            .tint(.white) // Tüm tint renklerini beyaz yap
        }
    }
}

struct CategorySectionView: View {
    let title: String // Kategori başlığı (örnek: "Popüler Filmler")
    let movies: [MovieModel] // Gösterilecek filmler
    let loadMore: () -> Void // Son filme gelindiğinde çağrılacak fonksiyon
    let onMovieTap: (MovieModel) -> Void // Filme tıklanınca ne yapılacak

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.headline)
                Spacer()
            }

            // Yatay kaydırmalı film listesi
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(movies.indices, id: \.self) { index in
                        HomeMovieCell(movie: movies[index]) // Film kartı
                            .onTapGesture {
                                onMovieTap(movies[index]) // Filme tıklandığında işlem
                            }
                            .onAppear {
                                // Son film görünür olunca yeni sayfa yüklenir
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
