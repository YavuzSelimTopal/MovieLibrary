//
//  ContentView.swift
//  MovieLibrary
//
//  Created by MACim on 21.05.2025.
//

import SwiftUI

struct ContentView<ViewModel: HomeViewModel>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        HomeView()
    }
}

#Preview {
//    ContentView(viewModel: ContentViewModel())
}
