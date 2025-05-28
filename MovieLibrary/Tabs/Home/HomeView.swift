//
//  HomeView.swift
//  MovieLibrary
//
//  Created by MACim on 28.05.2025.
//

import SwiftUI

struct HomeView: View {
    
    @State var selectedTab: Int = 0

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                ProfileView().tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }.tag(1)
                
                ZStack {
                    Text("Home")
                }.tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(0)
                
                MovieSearchView().tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Search")
                }.tag(2)
                
            }
        }
    }
}

#Preview {
    HomeView()
}
