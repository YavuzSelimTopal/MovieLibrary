//
//  MovieSearchViewModel.swift
//  MovieLibrary
//
//  Created by MACim on 23.05.2025.
//

import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    private let searchService: SearchServiceProtocol
    
    @Published var posts: [PostsModel] = []
    
    var title: String {
        "Network Demo"
    }
    
    var body: String {
        "Hello, World!"
    }
    
    init (searchService: SearchServiceProtocol) {
        self.searchService = searchService
    }
    
    // Get request sample
    func getPosts() async {
        do {
            let posts = try await searchService.getPosts()
            self.posts = posts
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Post request sample with http body
    func createPost() async {
        do {
            let post = try await searchService.createPost(title: title, body: body, userId: 1)
            print(post)
        } catch {
            print(error.localizedDescription)
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
