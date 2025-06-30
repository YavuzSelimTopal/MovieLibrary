//
//  TabbarView.swift
//  MovieLibrary
//
//  Created by MACim on 9.06.2025.
//

import SwiftUI

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: Int = 0
    @Environment(\.viewFactory) var viewFactory

    init() {
        // Yeni bir UITabBar görünümü (appearance) oluşturuluyor.
        let tabBarAppearance = UITabBarAppearance()
        
        // Sekme çubuğunun arka planı şeffaf olacak şekilde yapılandırılıyor.
        tabBarAppearance.configureWithTransparentBackground()
        
        // Arka plan rengi siyah olarak ayarlanıyor ama %85 saydam (yani hafif şeffaf).
        tabBarAppearance.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        
        // Oluşturulan görünüm varsayılan sekme çubuğu görünümü olarak atanıyor.
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        // iOS 15+ için, scroll ederken kullanılan görünüm de aynı şekilde atanıyor.
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

    var body: some View {
        TabView(selection: $selectedTab) {
           

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person.circle")
                Text("Profile")
            }
            .tag(1)

            viewFactory.homeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            NavigationStack {
                MovieSearchView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass.circle.fill")
                Text("Search")
            }
            .tag(2)
        }
        .tint(.red)
    }
}

#Preview {
    TabBarView()
}
