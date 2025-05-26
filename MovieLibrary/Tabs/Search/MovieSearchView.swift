//
//  MovieSearchView.swift
//  MovieLibrary
//
//  Created by MACim on 23.05.2025.
//

import SwiftUI


struct MovieSearchView<ViewModel: MovieSearchViewModel>: View {
  
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
          
            List(viewModel.users) { user in
                VStack(alignment: .leading) {
                   
                    Text(user.name)
                }
            }
            
            .navigationTitle("Kullanıcılar")
           
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    //MovieSearchView()
}
