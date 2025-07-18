//
//  MovieDetailView.swift
//  MovieLibrary
//
//  Created by MACim on 4.06.2025.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: MovieModel

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    if let backdrop = movie.backdropURL {
                        AsyncImage(url: backdrop) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(15)
                        } placeholder: {
                            Color.gray
                        }
                    }

                    Text(movie.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(.red)

                    Text("Çıkış Tarihi: \(movie.releaseDate)")
                        .font(.subheadline)
                        .foregroundColor(.red)

                    Text("Puan: \(String(format: "%.1f", movie.voteAverage))/10")
                        .font(.subheadline)
                        .foregroundColor(.orange)

                    Divider()

                    Text(movie.overview)
                        .font(.body)
                        .foregroundColor(.red)

                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .tint(.red)
    }
}
#Preview {
    MovieDetailView(movie: MovieModel(
        id: 1,
        title: "Test Filmi",
        overview: "Bu bir test filmidir. Açıklama burada yer alır.",
        posterURL: nil,
        backdropURL: nil,
        releaseDate: "2025-06-04",
        voteAverage: 7.8
    ))
}
