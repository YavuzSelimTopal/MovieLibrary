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
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.red)
                    TextField("Search movies…", text: $viewModel.searchText)
                        .foregroundColor(.red)
                }
                .padding(12)
                .background(Color.white.opacity(0.9))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 2)
                        .shadow(color: Color.red.opacity(0.7), radius: 10, x: 0, y: 0)
                        .shadow(color: Color.red.opacity(0.5), radius: 20, x: 0, y: 0)
                )
                .padding()
                
                ScrollView {
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
