//
//  SearchEndPoint.swift
//  MovieLibrary
//
//  Created by MACim on 24.05.2025.
//

import Foundation

// API isteklerini tanımlamak için kullanılan enum. Burada farklı endpointler belirtilebilir.
enum SearchEndpoint {
    case getMovies
}

extension SearchEndpoint: EndpointProtocol {
    // API'nin temel URL'sini belirtir. Bu URL, tüm isteklerin ortak başlangıç noktasıdır.
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com"  // Örnek baseURL, kendi API adresini yaz
    }
    
    // Her bir endpoint için istek yapılacak path bilgisini döner.
    var path: String {
        switch self {
        case .getMovies:
            return "/users"  // İlgili path ve API key
        }
    }
    
    // HTTP metodunu belirtir. GET, POST, PUT, DELETE gibi metodlar olabilir.
    // Burada sadece getMovies isteği için GET metodu kullanılıyor.
    var method: HttpMethod {
        return .get  // getMovies isteği için GET metodu kullanılıyor
    }
    
    // İstek sırasında gönderilecek header bilgilerini içerir.
    // Örneğin Content-Type, Authorization gibi headerlar burada tanımlanabilir.
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]  // Gerekirse header bilgisi
    }
    
    // URLRequest objesi oluşturur ve yapılandırır.
    // baseURL ve path birleştirilerek tam URL oluşturulur.
    // HTTP metodu ve header bilgileri request'e eklenir.
    func request() -> URLRequest {
        let urlString = baseURL + path
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}
