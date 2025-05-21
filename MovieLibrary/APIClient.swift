//
//  APIClient.swift
//  MovieLibrary
//
//  Created by MACim on 21.05.2025.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

class APIClient {
    
    //Url ve hangi model dönecekse onu seçeceğiz
    func fetch<T: Decodable>(urlString: String,responseType: T.Type) async throws -> T {
        
        //url doğrumu kontrol edeceğiz
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        do {
            //url ye istek göndereceğiz
            let (data, response ) = try await URLSession.shared.data(from: url)
            
            //http cevabı 200 ile 299 arasında mı onu kontrol edeceğiz
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            // Json dan model nesnesi üretir(verdiğimiz T modeline göre gelen data yı decode eder)
            do {
                let decoded = try JSONDecoder().decode(T.self,from: data)
                return decoded
            }catch {
                throw APIError.decodingFailed(error)
            }
        }catch {
            throw APIError.requestFailed(error)
        }
        
    }
}
