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
}

extension NetworkRequest: TargetType {
    
    var enviromentBaseURL: String {
        switch NetworkManager.enviroment {
        case.popularMovie: return "https://api.themoviedb.org"
        case.listMovie: return "https://api.themoviedb.org"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: enviromentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getMovies:
            return "3/movie/popular"
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
        case .getMovies:
            return .requestParameters(parameters: ["api_key" : "9f041eb26e51673e9eb8ba9e63adb9fe", "language" : "en-US", "page" : "1"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
