//
//  ResourceType.swift
//  SampleNetworking
//
//  Created by Huy on 11/30/20.
//

import Foundation

public protocol Resource {
    var baseURL: URL { get }
    var endpoint: Endpoint { get }
    var task: Task { get }
    var headers: [String: String] { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

public extension Resource {
    var cachePolicy: URLRequest.CachePolicy {
        return .useProtocolCachePolicy
    }
}
