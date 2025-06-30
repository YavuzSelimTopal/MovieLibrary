//
//  ViewFactory.swift
//  MovieLibrary
//
//  Created by MACim on 20.06.2025.
//

import SwiftUI

@MainActor
struct ViewFactory {
    
    func homeView() -> some View {
        HomeView(viewModel: HomeViewModel(movieService: MovieService(requestProcessor: RequestProcessor())))
    }
    
    //profile
    
    //search
}

private struct ViewFactoryEnvironmentKey: EnvironmentKey {
    typealias Value = ViewFactory
    
    @MainActor
    static var defaultValue: ViewFactory {
        ViewFactory()
    }
}

extension EnvironmentValues {
    var viewFactory: ViewFactory {
        get { self[ViewFactoryEnvironmentKey.self] }
        set { self[ViewFactoryEnvironmentKey.self] = newValue }
    }
}
