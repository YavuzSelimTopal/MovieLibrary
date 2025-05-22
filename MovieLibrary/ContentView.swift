//
//  ContentView.swift
//  MovieLibrary
//
//  Created by MACim on 21.05.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GenericViewModel<UserElement>(urlString: "https://jsonplaceholder.typicode.com/users")
    
    var body: some View {
        NavigationView {
            List(viewModel.items) { post in
                VStack(alignment: .leading) {
                    Text(post.name)
                }
            }
            .navigationTitle("Kullanıcılar")
            .task {
                await viewModel.fetch()
            }
        }
    }
}
#Preview {
    ContentView()
}
