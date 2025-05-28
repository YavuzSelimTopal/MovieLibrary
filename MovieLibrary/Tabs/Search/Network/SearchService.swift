//
//  SearchService.swift
//  MovieLibrary
//
//  Created by MACim on 23.05.2025.
//

import Foundation


import Foundation

protocol SearchServiceProtocol {
    func getPosts() async throws -> [PostsModel]
    func createPost(title: String, body: String, userId: Int) async throws -> PostsModel
}

final class SearchService: SearchServiceProtocol {
    private let requestProcessor: RequestProcessorProtocol
    
    init(requestProcessor: RequestProcessorProtocol) {
        self.requestProcessor = requestProcessor
    }
    
    func getPosts() async throws -> [PostsModel] {
        try await requestProcessor.request(
            endpoint: SearchRouter.getPosts, type: [PostsDTO].self
        )
        .map { dto in
            PostsModel.init(dto: dto)
        }
    }
    
    func createPost(title: String, body: String, userId: Int) async throws -> PostsModel {
        let dto = try await requestProcessor.request(
            endpoint: SearchRouter.createPost(title: title, body: body, userId: userId), type: PostsDTO.self
        )
        return PostsModel(dto: dto)
    }
}


