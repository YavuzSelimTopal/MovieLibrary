//
//  SingleMovieView.swift
//  MovieLibrary
//
//  Created by MACim on 30.06.2025.
//

import SwiftUI

struct SingleMovieView: View {
    @ObservedObject var viewModel: SingleMovieViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.Showcasetitle)
                .foregroundStyle(.red)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)

            if let movie = viewModel.movie {
                SingleMovieCell(movie: movie)
                    .onTapGesture {
                        viewModel.onMovieTap(movie)
                    }
                    .padding(.horizontal)
            } else {
                ProgressView()
                    .padding()
            }
        }
    }
}

#Preview {
    SingleMovieView(
        viewModel: SingleMovieViewModel(
            movieService: MovieService(requestProcessor: RequestProcessor()),
            onMovieTap: { _ in }
        )
    )
}
