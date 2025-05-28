//
//  ContentView.swift
//  MovieLibrary
//
//  Created by MACim on 21.05.2025.
//

import SwiftUI

struct ContentView<ViewModel: SearchViewModel>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Button("Create Post") {
                Task { await viewModel.createPost() }
            }
            
            
            List(viewModel.posts) { post in
                VStack {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                }
            }
            .padding()
        }
        .task {
            await viewModel.getPosts()
        }
    }
}

#Preview {
//    ContentView(viewModel: ContentViewModel())
}
