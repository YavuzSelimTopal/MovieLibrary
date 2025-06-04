//
//  MovieLibraryApp.swift
//  MovieLibrary
//
//  Created by MACim on 21.05.2025.
//

import SwiftUI

@main
struct MovieLibraryApp: App {
    @State var showSplashScreen: Bool = true

    var body: some Scene {
        WindowGroup {
            if showSplashScreen {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            showSplashScreen = false
                        }
                    }
            } else {
                ContentView(viewModel: HomeViewModel(movieService: MovieService(requestProcessor: RequestProcessor())))
            }
        }
    }
}
