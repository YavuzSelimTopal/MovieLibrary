//
//  HomeMovieCell.swift
//  MovieLibrary
//
//  Created by MACim on 29.05.2025.
//

import SwiftUI

struct HomeMovieCell: View {
    let movie: MovieModel

    var body: some View {
        VStack(alignment: .leading) {
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 150, height: 225)
                .cornerRadius(15)
                .shadow(radius: 5)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 225)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            Text(movie.title)
                .font(.caption)
                .lineLimit(1)
                .frame(width: 150, alignment: .leading)
        }
    }
}


#Preview {
    let sampleDTO = MovieDTO(
        id: 1,
        title: "Thor",
        originalTitle: "Thor",
        posterPath: "/sample.jpg",
        backdropPath: "/sample_backdrop.jpg",
        overview: "Thor film açıklaması...",
        releaseDate: "2023-07-10",
        voteAverage: 8.3,
        voteCount: 1200,
        popularity: 500.0,
        genreIds: [28, 12],
        originalLanguage: "en",
        video: false,
        adult: false
    )
    
    HomeMovieCell(movie: MovieModel(dto: sampleDTO))
}
