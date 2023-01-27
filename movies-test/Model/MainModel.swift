//
//  MainModel.swift
//  movies-test
//
//  Created by Paulo Lazarini on 28/12/22.
//


import Foundation
import Moya

struct Movie: Decodable {
    let title: String
    let id: Int
    let poster_path: String
    let overview: String
    let release_date: String
}

struct MovieResults: Decodable {
    let results: [Movie]
    let page: Int?
}

