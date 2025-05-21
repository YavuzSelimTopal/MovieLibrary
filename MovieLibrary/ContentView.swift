//
//  ContentView.swift
//  MovieLibrary
//
//  Created by MACim on 21.05.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel() // ViewModel bağlandı

    var body: some View {
        NavigationView {
            List {
                // Kullanıcılar döngüye alınıyor
                ForEach(viewModel.users, id: \.id) { user in
                    VStack(alignment: .leading) {
                        Text(user.name) // Kullanıcının adı
                            .font(.headline)

                        Text("@\(user.username)") // Kullanıcının kullanıcı adı
                            .foregroundColor(.gray)

                        Text(user.email) // Kullanıcının e-posta adresi
                            .font(.subheadline)

                        Text(user.address.city) // Kullanıcının yaşadığı şehir
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 5)
                }            }
            .navigationTitle("Kullanıcılar")
            .task {
                await viewModel.fetchUsers() // Sayfa açılınca veriyi çek
            }
        }
    }
}
#Preview {
    ContentView()
}
