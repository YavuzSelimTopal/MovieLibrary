//
//  MovieLibraryApp.swift
//  MovieLibrary
//
//  Created by MACim on 21.05.2025.
//

import SwiftUI

@main
struct MovieLibraryApp: App {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.red]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.red]

        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.red]
        appearance.backButtonAppearance = backButtonAppearance

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

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
                //TODO: TabbarView
                ContentView(viewModel: HomeViewModel(movieService: MovieService(requestProcessor: RequestProcessor())))
            }
        }
    }
}
/*
 1- TabbarView = +
 2- Loading Indicator (lottie ios, swiftui network state management) = + (geç çalışıyor)
 3- Movie of the day = + (emilatör de yükleniyor da kalıyors)
 4- gereksiz kodları sil  +
 5- showcase i çöz  +
 6- detay sayfasını çöz  +
 7- Arama sayfasını tasarla düşün. +
 */
