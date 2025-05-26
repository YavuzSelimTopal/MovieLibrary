//
//  MovieSearchViewModel.swift
//  MovieLibrary
//
//  Created by MACim on 23.05.2025.
//

import Foundation

@MainActor
class MovieSearchViewModel: ObservableObject {
    @Published var users: [UserElement] = []

    private let searchService: SearchService
    
    init(searchService: SearchService) {
        self.searchService = searchService
    }

    func fetchUsers() async {
        do {
            let users = try await searchService.users()
            self.users = users
        } catch {
            print(error)
        }
    }
}





/*
 home
    - populer
 search
 planned, saved
 profile
 */
