//
//  NetworkManager.swift
//  movies-test
//
//  Created by Paulo Lazarini on 28/12/22.
//

import Foundation
import Combine
import Moya

protocol Networkable {
    var provider: MoyaProvider<NetworkRequest> { get }
    func getNewMovies(page: Int, completion: @escaping ([Movie]) -> ())
    func getGenreList(completion: @escaping ([Genre]) -> ())
}

enum APIEnviroment {
    case popularMovie
//    case listMovie
}

struct NetworkManager: Networkable {
    func getGenreList(completion: @escaping ([Genre]) -> ()) {
        provider.request(.getGenre) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Genres.self, from: response.data)
                    completion(results.genres)
                } catch let err {
                    print(err)

                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    var provider = MoyaProvider<NetworkRequest>()
    static let enviroment: APIEnviroment = .popularMovie
    
    func getNewMovies(page: Int, completion: @escaping ([Movie])->()) {
        provider.request(.getMovies(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResults.self, from: response.data)
                    completion(results.results)
                } catch let err {
                    print(err)

                }
            case let .failure(error):
                print(error)
            }
        }
    }
}




