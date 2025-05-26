//
//  ContentView.swift
//  MovieLibrary
//
//  Created by MACim on 21.05.2025.
//

import SwiftUI

struct ContentView<ViewModel: MovieSearchViewModel>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
       MovieSearchView(viewModel: viewModel)
    }
}
#Preview {
    // ContentView()
}
