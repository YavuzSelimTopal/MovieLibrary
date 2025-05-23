//
//  ContentView.swift
//  MovieLibrary
//
//  Created by MACim on 21.05.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GenericViewModel<UserElement>(urlString: Constants.URL.userExtenstion)
    
    var body: some View {
        NavigationView {
            List(viewModel.FetchModelName) { post in
                VStack(alignment: .leading) {
                    Text(post.name)
                }
            }
            .navigationTitle("Kullanıcılar")
            .task {
                await viewModel.fetchViewModel()
            }
        }
    }
}
#Preview {
    ContentView()
}
