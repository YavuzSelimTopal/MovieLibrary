//
//  CategoriesSectionView.swift
//  MovieLibrary
//
//  Created by MACim on 20.06.2025.
//

import SwiftUI

struct CategorySectionView: View {
    @StateObject var viewModel: CategoriesSectionViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.movieType?.title ?? "")
                    .foregroundStyle(.red) // Kırmızı başlıklar
                    .font(.headline)
                Spacer()
            }

            // Yatay kaydırmalı film listesi
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.movies.indices, id: \.self) { index in
                        HomeMovieCell(movie: viewModel.movies[index])
                            .onTapGesture {
                                viewModel.onMovieTap(viewModel.movies[index])
                            }
                    }
                }
            }
        }
        .task {
            await viewModel.fetchMovies()
        }
    }
}


#Preview {
    CategorySectionView(viewModel: CategoriesSectionViewModel(movieService: MovieService(requestProcessor: RequestProcessor()), movieType: .popularMovies, onMovieTap: { _ in }))
}
