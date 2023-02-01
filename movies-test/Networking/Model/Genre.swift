//
//  Genre.swift
//  movies-test
//
//  Created by Paulo Lazarini on 30/01/23.
//

import Foundation

struct Genres: Codable {
    
    let genres: [Genre]
    
}

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}
