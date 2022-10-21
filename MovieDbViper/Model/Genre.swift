//
//  Genre.swift
//  MovieDbViper
//
//  Created by Hansel Matthew on 21/10/22.
//

import Foundation

struct GenresResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
