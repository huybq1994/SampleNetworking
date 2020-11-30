//
//  Networking.swift
//  SampleNetworking
//
//  Created by Huy on 11/30/20.
//

import Foundation

public class Networking<R: Resource>: NetworkingType {

    public init() { }

    @discardableResult
    public func request(
        resource: R,
        session: NetworkingSession = URLSession.shared,
        queue: DispatchQueue = .main,
        completion: @escaping (Result<Response, NetworkingError>) -> Void
    ) -> URLSessionDataTask {
        let request = URLRequest(resource: resource)
        return session.loadData(with: request, queue: queue) { response, error in
            if let error = error {
                completion(.failure(.underlying(error, response)))
                return
            }

            guard let httpURLResponse = response.httpURLResponse,
                200..<300 ~= httpURLResponse.statusCode else {
                    completion(.failure(.statusCode(response)))
                    return
            }

            completion(.success(response))
        }
    }
}
