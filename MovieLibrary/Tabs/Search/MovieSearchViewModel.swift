//
//  MovieSearchViewModel.swift
//  MovieLibrary
//
//  Created by MACim on 19.07.2025.
//

import Foundation
import Combine

final class MovieSearchViewModel: ObservableObject {
    
    // Kullanıcının arama kutusuna yazdığı metin (binding ile View'de gösterilir/güncellenir)
    @Published var searchText: String = ""
    @Published var allMovies: [MovieModel] = []
    
    // Arama sonucuna göre filtrelenmiş (gösterilecek) filmler burada tutulur
    @Published var filteredMovies: [MovieModel] = []
    
    private let movieService: MovieServiceProtocol
    
    // Combine framework kullanılarak arama metni değişiklikleri dinlenir ve abonelikler burada saklanır
    private var cancellables = Set<AnyCancellable>()
    
    // ViewModel oluşturulurken çağrılır
    // movieService atanır, arama metni dinlenmeye başlanır ve başlangıçta tüm filmler çekilir
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService // Movie servis nesnesi atanır
        observeSearchText() // Arama kutusu değişikliklerini dinleyen fonksiyon çağrılır
        Task {
            await fetchAllMovies() // Uygulama açılır açılmaz tüm filmler API'den çekilir
        }
    }
    
    // Arama metni değiştikçe tetiklenen fonksiyon
    private func observeSearchText() {
        $searchText
            // Kullanıcı yazmayı bıraktıktan 300 ms sonra tetiklenir (gereksiz fazla aramayı önler)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            // Yeni arama metni geldiğinde çalışır
            .sink { [weak self] newValue in
                // Eğer arama kutusu boşsa tüm filmler gösterilir
                if newValue.isEmpty {
                    self?.filteredMovies = self?.allMovies ?? []
                } else {
                    // Arama kutusu doluysa API'den arama yap ve sonuçları göster
                    self?.searchMovies(query: newValue)
                }
            }
            // Aboneliği cancellables setine kaydet (hafıza yönetimi için)
            .store(in: &cancellables)
    }
    
    // Verilen arama sorgusuna göre API'den film verisi çekip filtreler
    private func searchMovies(query: String) {
        Task {
            do {
                // Burada tüm filmleri çekiyor, sonra filtreliyor
                // arama endpoint i varsa o da olur MARK: Ali Abiye sor
                let movies = try await movieService.getAllMovies(page: 1)
                
                // Başlıklarda arama sorgusunu içerenler filtreleniyor (büyük/küçük harf duyarsız)
                let filtered = movies.filter {
                    $0.title.lowercased().contains(query.lowercased())
                }
                
                // UI güncellemesi MainThread'de yapılmalı
                await MainActor.run {
                    self.filteredMovies = filtered
                }
            } catch {
                // API çağrısı ya da filtreleme sırasında hata olursa yazdır
                print("Arama sırasında hata oluştu: \(error)")
            }
        }
    }
    
    // Uygulama açıldığında tüm filmleri çeker
    @MainActor
    func fetchAllMovies() async {
        do {
            // Sayfa 1'deki tüm filmleri getir
            let movies = try await movieService.getAllMovies(page: 1)
            // Gelen tüm filmleri allMovies değişkenine ata
            self.allMovies = movies
            // Başlangıçta tüm filmler listede gösterilir
            self.filteredMovies = movies
        } catch {
            // Hata varsa konsola yazdır
            print("Tüm filmleri çekerken hata oluştu: \(error)")
        }
    }
}
