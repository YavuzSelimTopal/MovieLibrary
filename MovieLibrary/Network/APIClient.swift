//
//  APIClient.swift
//  MovieLibrary
//
//  Created by MACim on 21.05.2025.
//

import Foundation

// API istekleri sırasında oluşabilecek hata türlerini tanımlayan enum
enum APIError: Error {
    case invalidURL              // Geçersiz URL hatası
    case requestFailed(Error)    // İstek başarısız olduğunda oluşan hata
    case invalidResponse         // Geçersiz veya beklenmeyen HTTP yanıtı
    case decodingFailed(Error)   // JSON verisi decode edilirken oluşan hata
}

// APIClient sınıfı, API isteklerini yapmak ve sonuçları decode etmek için kullanılır
final class APIClient {
    
    // Genel amaçlı asenkron fetch fonksiyonu
    // T: Decodable protokolünü uygulayan herhangi bir model tipi olabilir
    // endpoint: API isteği için gerekli bilgileri sağlayan EndpointProtocol tipinde bir parametre
    // Fonksiyon, verilen endpoint'ten veri çekip, belirtilen model tipine decode ederek döner
    static func fetch<T: Decodable>(type: T.Type, from endpoint: EndpointProtocol) async throws -> T {
        // Endpoint'ten URLRequest oluşturulur
        let request = endpoint.request()
        
        do {
            // URLSession ile asenkron veri ve yanıt alınır
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Gelen yanıtın HTTPURLResponse olup olmadığı ve başarılı HTTP status kodu kontrol edilir
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                // Yanıt geçerli değilse hata fırlatılır
                throw APIError.invalidResponse
            }
            
            do {
                // Gelen JSON verisi belirtilen tipe decode edilir
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return decoded
            } catch {
                // Decode işlemi başarısızsa hata fırlatılır
                throw APIError.decodingFailed(error)
            }
            
        } catch {
            // Veri çekme işlemi sırasında hata oluşursa hata fırlatılır
            throw APIError.requestFailed(error)
        }
    }
}
