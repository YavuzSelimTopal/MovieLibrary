//
//  UserViewModel.swift
//  MovieLibrary
//
//  Created by MACim on 21.05.2025.
//

import Foundation

//@MainActor
//class UserViewModel: ObservableObject {
//    @Published var users: [UserElement] = []
//
//    private let apiClient = APIClient()
//
//    func fetchUsers() async {
//        do {
//            let result = try await apiClient.fetch(
//                urlString: "https://jsonplaceholder.typicode.com/users",
//                responseType: [UserElement].self
//            )
//
//            self.users = result
//        } catch {
//            print("Hata: \(error.localizedDescription)")
//        }
//    }
//}
