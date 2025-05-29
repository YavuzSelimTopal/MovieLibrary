//
//  HomeMovieCell.swift
//  MovieLibrary
//
//  Created by MACim on 29.05.2025.
//

import SwiftUI

struct HomeMovieCell: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image ("movie")
                    .resizable()
                    //.aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 150)
                    .shadow(radius: 5)
                    .cornerRadius(15)
                Text("Thor")
            }
        }
    }
}

#Preview {
    HomeMovieCell()
}
