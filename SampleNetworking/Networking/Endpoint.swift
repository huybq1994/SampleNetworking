//
//  Endpoint.swift
//  SampleNetworking
//
//  Created by Huy on 11/30/20.
//

import Foundation

public enum Endpoint {
    case get(path: String)
    case post(path: String)
    case put(path: String)
    case delete(path: String)
    case patch(path: String)

    internal enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
    }

    internal var path: String {
        switch self {
        case let .get(path),
             let .post(path),
             let .put(path),
             let .delete(path),
             let .patch(path):
            return path
        }
    }

    internal var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        case .patch:
            return .patch
        }
    }

    internal var defaultParamDestination: ParamDestination {
        switch self {
        case .get:
            return .urlQuery
        case .post, .put, .delete, .patch:
            return .httpBody
        }
    }
}
