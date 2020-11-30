//
//  URLSession+Extentions.swift
//  SampleNetworking
//
//  Created by Huy on 11/30/20.
//

import Foundation

public protocol NetworkingSession {
    typealias CompletionHandler = (Response, Swift.Error?) -> Void
    func loadData(
        with urlRequest: URLRequest,
        queue: DispatchQueue,
        completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask
}

extension URLSession: NetworkingSession {
    public func loadData(
        with urlRequest: URLRequest,
        queue: DispatchQueue,
        completionHandler: @escaping (Response, Swift.Error?) -> Void
    ) -> URLSessionDataTask {
        let task = dataTask(with: urlRequest) { data, urlResponse, error in
            queue.async {
                let response = Response(
                    urlRequest: urlRequest,
                    data: data,
                    httpURLResponse: urlResponse as? HTTPURLResponse
                )
                completionHandler(response, error)
            }
        }
        task.resume()
        return task
    }
}
