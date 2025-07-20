//
//  MovieSearchCellView.swift
//  MovieLibrary
//
//  Created by MACim on 19.07.2025.
//

import SwiftUI

struct MovieSearchCellView: View {
    let movie: MovieModel
    
    var body: some View {
        VStack(alignment: .leading) {
            // Poster resmi varsa göster, yoksa gri placeholder
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { phase in
                    switch phase {
                    case .empty:
                        Color.gray.opacity(0.3)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure(_):
                        Color.red.opacity(0.3)
                    @unknown default:
                        Color.gray.opacity(0.3)
                    }
                }
                .frame(width: 150, height: 225)
                .cornerRadius(15)
                .shadow(radius: 5)
            } else {
                Color.gray
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
            }
            
            // Film başlığı
            Text(movie.title)
                .font(.headline)
                .lineLimit(2)
                .foregroundColor(.red)
                .frame(width: 150, alignment: .center)
        }
        .padding(8)
    }
}

#Preview {
    MovieSearchCellView(movie: MovieModel(
        id: 1,
        title: "Örnek Film",
        overview: "Kısa film açıklaması burada yer alır.",
        posterURL: URL(string: "https://image.tmdb.org/t/p/w500/samplePoster.jpg"),
        backdropURL: URL(string: "https://image.tmdb.org/t/p/w780/sampleBackdrop.jpg"),
        releaseDate: "2025-01-01",
        voteAverage: 8.2
    ))
}
