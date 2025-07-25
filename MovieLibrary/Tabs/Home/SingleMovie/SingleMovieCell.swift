//
//  SingleMovieCell.swift
//  MovieLibrary
//
//  Created by MACim on 30.06.2025.
//

import SwiftUI

struct SingleMovieCell: View {
    let movie: MovieModel

    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: movie.posterURL) { image in
                image
                    .resizable()
                    .frame(width: 350, height: 300)
                    .cornerRadius(12)
                    .redBorder(cornerRadius: 12)
            } placeholder: {
                Color.gray
                    .frame(width: 350, height: 300)
                    .cornerRadius(12)
            }

            Text(movie.title)
                .foregroundColor(.red)
                .font(.title3.bold())
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SingleMovieCell(movie: MovieModel(
        id: 1,
        title: "Preview Movie",
        overview: "Example overview",
        posterURL: URL(string: "https://image.tmdb.org/t/p/w500/example.jpg"),
        backdropURL: URL(string: "https://image.tmdb.org/t/p/w780/example_backdrop.jpg"),
        releaseDate: "2025-06-30",
        voteAverage: 8.2
    ))
}
