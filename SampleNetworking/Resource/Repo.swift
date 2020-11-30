//
//  Repo.swift
//  SampleNetworking
//
//  Created by Huy on 11/30/20.
//

import Foundation

enum Repo {
    case search(name: String)
}

extension Repo: Resource {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    var endpoint: Endpoint {
        switch self {
        case .search:
            return .get(path: "search/repositories")
        }
    }

    var task: Task {
        switch self {
        case let .search(name):
            let params: [String: Any] = ["q": name]
            return .requestWithParameters(params, encoding: URLEncoding())
        }
    }

    var headers: [String: String] {
        return [:]
    }

    var cachePolicy: URLRequest.CachePolicy {
        return .useProtocolCachePolicy
    }
}
