//
//  SearchViewModifier.swift
//  MovieLibrary
//
//  Created by MACim on 21.07.2025.
//

import Foundation
import SwiftUI

struct RedGlowBorder: ViewModifier {
    let cornerRadius: CGFloat
    
    init(cornerRadius: CGFloat = 10) {
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.red, lineWidth: 2)
                    .shadow(color: Color.red.opacity(0.7), radius: 10)
                    .shadow(color: Color.red.opacity(0.5), radius: 20)
            )
    }
}

extension View {
    func redBorder(cornerRadius: CGFloat = 10) -> some View {
        self.modifier(RedGlowBorder(cornerRadius: cornerRadius))
    }
}
