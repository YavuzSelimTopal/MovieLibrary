//
//  GenericViewModel.swift
//  MovieLibrary
//
//  Created by MACim on 23.05.2025.
//

import Foundation

@MainActor
class GenericViewModel<T: Decodable>: ObservableObject {
    @Published var items: [T] = []
    @Published var isLoading = false
    @Published var errorMesage: String?
    
    let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func fetch() async {
        isLoading = true
        errorMesage = nil
        
        do {
            let result = try await APIClient.fetch(urlString: urlString,responseType: [T].self)
            self.items = result
        } catch {
            self.errorMesage = error.localizedDescription
        }
        isLoading = false
    }
    
}


