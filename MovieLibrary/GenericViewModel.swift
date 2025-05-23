//
//  GenericViewModel.swift
//  MovieLibrary
//
//  Created by MACim on 23.05.2025.
//

import Foundation

@MainActor
class GenericViewModel<T: Decodable>: ObservableObject {
    @Published var FetchModelName: [T] = []
    
    let urlStringViewModel: String
    
    init(urlString: String) {
        self.urlStringViewModel = urlString
    }
    
    func fetchViewModel() async {
        
        do {
            let result = try await APIClient.fetch(urlString: urlStringViewModel,responseType: [T].self)
            self.FetchModelName = result
        } catch {
            
        }
    }
}


