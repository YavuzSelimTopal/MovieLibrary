//
//  HomeService.swift
//  MovieLibrary
//
//  Created by MACim on 28.05.2025.
//

import Foundation

protocol MovieServiceProtocol {
    func getActionMovies() async throws -> [MovieModel]
    func getComedyMovies() async throws -> [MovieModel]
    func getPopularMovies() async throws -> [MovieModel]
//    func getThisYearMovies() async throws -> [MovieModel]
    func getNowPlayingMovies() async throws -> [MovieModel]
    func getAnimationMovies() async throws -> [MovieModel]
    func getAllMovies() async throws -> [MovieModel]
    func searchMovies(query: String) async throws -> [MovieModel]
}

final class MovieService: MovieServiceProtocol {
    private let requestProcessor: RequestProcessorProtocol
    
    init(requestProcessor: RequestProcessorProtocol) {
        self.requestProcessor = requestProcessor
    }
    
    func getActionMovies() async throws -> [MovieModel] {
        let endpoint = HomeRouter.getAction
        let dto = try await requestProcessor.request(
            endpoint: endpoint,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }

    func getComedyMovies() async throws -> [MovieModel] {
        let endpoint = HomeRouter.getComedy
        let dto = try await requestProcessor.request(
            endpoint: endpoint,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }

    func getPopularMovies() async throws -> [MovieModel] {
        let endpoint = HomeRouter.getPopular
        let dto = try await requestProcessor.request(
            endpoint: endpoint,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }
    
//    func getThisYearMovies() async throws -> [MovieModel] {
//        let endpoint = HomeRouter.getThisYear()
//        let dto = try await requestProcessor.request(
//            endpoint: endpoint,
//            type: MovieResponseDTO.self
//        )
//        return dto.results.map { MovieModel(dto: $0) }
//    }

    func getNowPlayingMovies() async throws -> [MovieModel] {
        let endpoint = HomeRouter.getNowPlaying
        let dto = try await requestProcessor.request(
            endpoint: endpoint,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }

    func getAnimationMovies() async throws -> [MovieModel] {
        let endpoint = HomeRouter.getAnimation
        let dto = try await requestProcessor.request(
            endpoint: endpoint,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }

    func getAllMovies() async throws -> [MovieModel] {
        let endpoint = HomeRouter.getAllMovies
        let dto = try await requestProcessor.request(
            endpoint: endpoint,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }

    func searchMovies(query: String) async throws -> [MovieModel] {
        let endpoint = SearchRouter.search(query: query)
        let dto = try await requestProcessor.request(
            endpoint: endpoint,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }
}
