//
//  SplashScreen.swift
//  MovieLibrary
//
//  Created by MACim on 3.06.2025.
//

import SwiftUI

struct SplashScreen: View {
    @State private var pulse = false
    @State private var moveUp = false
    @State private var showText = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                Image("movie")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.red)
                    .scaleEffect(pulse ? 1.1 : 1.0)
                    //.opacity(moveUp ? 0.5 : 1.0)
                    .offset(y: moveUp ? -150 : 0)
                    .animation(.easeInOut(duration: 1.0).repeatCount(3, autoreverses: true), value: pulse)
                    .padding(.bottom, -30)

                if showText {
                    Text("Movie Library")
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundColor(.red)
                        .transition(.opacity)
                        .animation(.easeIn(duration: 1.0), value: showText)
                        .padding(.top, 0)
                        .offset(y: -100)
                }
            }
        }
        .onAppear {
            pulse.toggle()

            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    moveUp = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        showText = true
                    }
                }
            }
        }
    }
}
#Preview {
    SplashScreen()
}
