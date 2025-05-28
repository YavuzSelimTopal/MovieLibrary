//
//  MovieLibraryApp.swift
//  MovieLibrary
//
//  Created by MACim on 21.05.2025.
//

import SwiftUI

@main
struct MovieLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: SearchViewModel(searchService: SearchService(requestProcessor: RequestProcessor())))
        }
    }
}
