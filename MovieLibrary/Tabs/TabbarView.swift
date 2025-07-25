//
//  TabbarView.swift
//  MovieLibrary
//
//  Created by MACim on 9.06.2025.

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: Int = 0
    @Environment(\.viewFactory) var viewFactory

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                switch selectedTab {
                case 0:
                    viewFactory.homeView()
                case 1:
                    ProfileView()
                case 2:
                    viewFactory.searchView()
                default:
                    viewFactory.homeView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)

            HStack(spacing: 65) {
                tabItem(icon: "person.fill", index: 1)
                tabItem(icon: "film.stack.fill", index: 0, isCenter: true)
                tabItem(icon: "magnifyingglass.circle.fill", index: 2)
            }
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.65).edgesIgnoringSafeArea(.bottom))
            .clipShape(RoundedRectangle(cornerRadius: 0))
            .shadow(color: .red.opacity(0.3), radius: 10, x: 0, y: -2)
        }
        .ignoresSafeArea()
        .background(Color.black)
        .accentColor(.red)
    }
    
    @ViewBuilder
    private func tabItem(icon: String, index: Int, isCenter: Bool = false) -> some View {
        Button(action: {
            withAnimation(.spring()) {
                selectedTab = index
            }
        }) {
            ZStack {
                Circle()
                    .fill(Color.black.opacity(0.8))
                    .frame(width: isCenter ? 65 : 50, height: isCenter ? 65 : 50)
                    .shadow(color: selectedTab == index ? .red.opacity(0.7) : .clear, radius: 10)
                    .overlay(
                        Circle()
                            .stroke(selectedTab == index ? Color.red : Color.gray.opacity(0.3), lineWidth: 2)
                    )
                
                Image(systemName: icon)
                    .font(.system(size: isCenter ? 26 : 22, weight: .semibold))
                    .foregroundColor(selectedTab == index ? .red : .gray)
                    .scaleEffect(selectedTab == index ? 1.2 : 1.0)
            }
        }
    }
}

#Preview {
    TabBarView()
}
