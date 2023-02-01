//
//  Network.swift
//  movies-test
//
//  Created by Paulo Lazarini on 28/12/22.
//

import Foundation
import Moya


enum NetworkRequest {
    case getMovies(page: Int)
    case getGenre
}

extension NetworkRequest: TargetType {
    
    static let MovieAPIKey = "9f041eb26e51673e9eb8ba9e63adb9fe"
    
    var enviromentBaseURL: String {
        switch NetworkManager.enviroment {
        case.popularMovie: return "https://api.themoviedb.org/3"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: enviromentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getMovies:
            return "/movie/popular"
        case .getGenre:
            return "/genre/movie/list"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getMovies(let page):
            return .requestParameters(parameters: ["api_key" : "\(NetworkRequest.MovieAPIKey)",
                                              "language" : "en-US",
                                              "page" : "\(page)"],
                                              encoding: URLEncoding.queryString)
        case .getGenre:
            return .requestParameters(parameters: ["api_key" : "\(NetworkRequest.MovieAPIKey)",
                                              "language" : "en-US"],
                                              encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
