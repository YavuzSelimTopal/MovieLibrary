//
//  HomeService.swift
//  MovieLibrary
//
//  Created by MACim on 28.05.2025.
//

import Foundation

protocol MovieServiceProtocol {
    func getActionMovies(page: Int) async throws -> [MovieModel]
    func getComedyMovies(page: Int) async throws -> [MovieModel]
    func getPopularMovies(page: Int) async throws -> [MovieModel]
    func getThisYearMovies(page: Int) async throws -> [MovieModel]
    func getNowPlayingMovies(page: Int) async throws -> [MovieModel]
    func getAnimationMovies(page: Int) async throws -> [MovieModel]
}

final class MovieService: MovieServiceProtocol {
    private let requestProcessor: RequestProcessorProtocol
    
    init(requestProcessor: RequestProcessorProtocol) {
        self.requestProcessor = requestProcessor
    }
    
    func getActionMovies(page: Int) async throws -> [MovieModel] {
        let endpoint = HomeRouter.getAction(page: page)
        let dto = try await requestProcessor.request(
            endpoint: endpoint,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }

    func getComedyMovies(page: Int) async throws -> [MovieModel] {
        let endpoint = HomeRouter.getComedy(page: page)
        let dto = try await requestProcessor.request(
            endpoint: endpoint,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }

    func getPopularMovies(page: Int) async throws -> [MovieModel] {
        let endpoint = HomeRouter.getPopular(page: page)
        let dto = try await requestProcessor.request(
            endpoint: endpoint,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }

    func getThisYearMovies(page: Int) async throws -> [MovieModel] {
        let endpoint = HomeRouter.getThisYear(page: page)
        let dto = try await requestProcessor.request(
            endpoint: endpoint,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }

    func getNowPlayingMovies(page: Int) async throws -> [MovieModel] {
        let endpoint = HomeRouter.getNowPlaying(page: page)
        let dto = try await requestProcessor.request(
            endpoint: endpoint,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }

    func getAnimationMovies(page: Int) async throws -> [MovieModel] {
        let endpoint = HomeRouter.getAnimation(page: page)
        let dto = try await requestProcessor.request(
            endpoint: endpoint,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }
}
