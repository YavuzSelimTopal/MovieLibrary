//
//  SearchService.swift
//  MovieLibrary
//
//  Created by MACim on 23.05.2025.
//

import Foundation

/// SearchService sınıfı, kullanıcı arama işlemleriyle ilgili servis fonksiyonlarını içerir.
/// Bu sınıf, API üzerinden kullanıcı verilerini asenkron olarak çeker ve ilgili modelleri döner.
final class SearchService {
    /// users() fonksiyonu, APIClient'ın generic fetch fonksiyonunu kullanarak SearchRouter.user endpoint'inden kullanıcı verilerini asenkron olarak çeker.
    /// Bu fonksiyon, kullanıcı listesini [UserElement] dizisi olarak döner.
    /// Hata durumunda exception fırlatır.
    func users() async throws -> [UserElement] {
        try await APIClient.fetch(type: [UserElement].self, from: SearchEndpoint.getMovies)
    }
}

