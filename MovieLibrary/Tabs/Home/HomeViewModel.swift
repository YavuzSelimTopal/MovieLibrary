//
//  HomeViewModel.swift
//  MovieLibrary
//
//  Created by MACim on 28.05.2025.
//


enum NetworkState {
    case loading
    case failed(Error)
    case loaded
}

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    private let movieService: MovieServiceProtocol
   
    @Published var state: NetworkState = .loaded

    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }

    

    
    

  

   
}
