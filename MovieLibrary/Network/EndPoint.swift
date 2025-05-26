//
//  EndPoint.swift
//  MovieLibrary
//
//  Created by MACim on 24.05.2025.
//

import Foundation

// HTTP isteklerinde kullanılacak olan metodları tanımlayan enum.
// Bu enum, GET, POST, DELETE ve PATCH gibi HTTP metodlarını string olarak temsil eder.
enum HttpMethod: String {
    case get = "GET"      // Veri almak için kullanılan HTTP metodu
    case post = "POST"    // Veri oluşturmak için kullanılan HTTP metodu
    case delete = "DELETE"// Veri silmek için kullanılan HTTP metodu
    case patch = "PATCH"  // Verinin kısmi olarak güncellenmesi için kullanılan HTTP metodu
}

// API endpoint'lerini tanımlamak için kullanılan protokol.
// Bu protokolü benimseyen yapılar, bir endpoint'in temel özelliklerini ve nasıl istek yapacağını belirtir.
protocol EndpointProtocol {
    // API'nin temel URL'si (örneğin "https://api.example.com")
    var baseURL: String { get }
    
    // Belirli endpoint'in yolu (örneğin "/movies" veya "/users/1")
    var path: String { get }
    
    // Bu endpoint için kullanılacak HTTP metodu (GET, POST, vb.)
    var method: HttpMethod { get }
    
    // İsteğe özel header bilgileri (örneğin yetkilendirme token'ları)
    var headers: [String: String]? { get }
    
    // Yukarıdaki bilgileri kullanarak URLRequest nesnesi oluşturur ve döner.
    // Bu metod, endpoint'e istek yapılmasını sağlar.
    func request() -> URLRequest
}
