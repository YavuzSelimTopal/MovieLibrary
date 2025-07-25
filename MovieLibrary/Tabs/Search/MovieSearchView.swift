//
//  MovieSearchView.swift
//  MovieLibrary
//
//  Created by MACim on 27.05.2025.
//

import SwiftUI

struct MovieSearchView: View {
    @StateObject var viewModel: MovieSearchViewModel
    
    
    
    // 2 sütunlu grid düzeni
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.red)
                            ZStack(alignment: .leading) {
                                TextField("", text: $viewModel.searchText)
                                    .foregroundColor(.red)
                                
                                if viewModel.searchText.isEmpty {
                                    Text("Search movies…")
                                        .foregroundColor(Color.red.opacity(0.5))
                                        .padding(.leading, 2)
                                }
                                
                            }
                        }
                        .padding(15)
                        .background(.ultraThinMaterial.opacity(0.65))
                        .cornerRadius(30)
                        .redBorder(cornerRadius: 30)
                        .padding(.horizontal)
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.filteredMovies, id: \.id) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    MovieSearchCellView(movie: movie)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .background(Color.black.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("What are you looking for?")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.red)
                }
            }
        }
    }
}

#Preview {
    MovieSearchView(viewModel: MovieSearchViewModel(movieService: MovieService(requestProcessor: RequestProcessor())))
}
