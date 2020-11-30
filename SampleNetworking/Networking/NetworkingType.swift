//
//  NetworkingType.swift
//  SampleNetworking
//
//  Created by Huy on 11/30/20.
//

import Foundation

public protocol NetworkingType {

    associatedtype Resource

    func request(
        resource: Resource,
        session: NetworkingSession,
        queue: DispatchQueue,
        completion: @escaping (Result<Response, NetworkingError>) -> Void
    ) -> URLSessionDataTask
}
