//
//  PostsModel.swift
//  MovieLibrary
//
//  Created by MACim on 27.05.2025.
//

import Foundation

struct PostsModel: Identifiable {
    let id: Int
    let title: String
    let body: String
    
    init(dto: PostsDTO) {
        self.id = dto.id
        self.title = dto.title
        self.body = dto.body
    }
}
