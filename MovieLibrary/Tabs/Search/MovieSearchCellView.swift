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
        VStack(spacing: 8) {
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
                            .transition(.opacity)
                    case .failure(_):
                        Color.red.opacity(0.3)
                    @unknown default:
                        Color.gray.opacity(0.3)
                    }
                }
                .frame(width: 150, height: 225)
                .clipped()
                .cornerRadius(15)
                .redBorder(cornerRadius: 15)
            } else {
                Color.gray
                    .frame(width: 150, height: 225)
                    .cornerRadius(15)
            }
            
            // Film başlığı
            Text(movie.title)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
                .frame(width: 150, height: 42, alignment: .top)
                .fixedSize(horizontal: false, vertical: true)
            
            // Oy ortalaması (puan)
            Text("★ \(String(format: "%.1f", movie.voteAverage))")
                .font(.caption)
                .foregroundColor(.yellow.opacity(0.8))
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.3))
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(color: .red.opacity(0.5), radius: 10, x: 0, y: 5)
        )
        .redBorder(cornerRadius: 20)
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
