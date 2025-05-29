//
//  HomeService.swift
//  MovieLibrary
//
//  Created by MACim on 28.05.2025.
//

import Foundation

import Foundation

protocol MovieServiceProtocol {
    func getActionMovies() async throws -> [MovieModel]
    func getComedyMovies() async throws -> [MovieModel]
    func getPopularMovies() async throws -> [MovieModel]
    func getThisYearMovies() async throws -> [MovieModel]
}

final class MovieService: MovieServiceProtocol {
    private let requestProcessor: RequestProcessorProtocol
    
    init(requestProcessor: RequestProcessorProtocol) {
        self.requestProcessor = requestProcessor
    }
    
    func getActionMovies() async throws -> [MovieModel] {
        let dto = try await requestProcessor.request(
            endpoint: HomeRouter.getAction,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }

    func getComedyMovies() async throws -> [MovieModel] {
        let dto = try await requestProcessor.request(
            endpoint: HomeRouter.getComedy,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }

    func getPopularMovies() async throws -> [MovieModel] {
        let dto = try await requestProcessor.request(
            endpoint: HomeRouter.getPopular,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }

    func getThisYearMovies() async throws -> [MovieModel] {
        let dto = try await requestProcessor.request(
            endpoint: HomeRouter.getThisYear,
            type: MovieResponseDTO.self
        )
        return dto.results.map { MovieModel(dto: $0) }
    }
}

