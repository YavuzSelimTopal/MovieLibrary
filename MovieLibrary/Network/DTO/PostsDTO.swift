//
//  PostDTO.swift
//  MovieLibrary
//
//  Created by MACim on 27.05.2025.
//

import Foundation

struct PostsDTO: Decodable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}
