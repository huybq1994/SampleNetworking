//
//  URL+Extentions.swift
//  SampleNetworking
//
//  Created by Huy on 11/30/20.
//

import Foundation

internal extension URL {
    func appendingQueryParameters(_ parameters: [String: Any], encoding: URLEncoding) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        urlComponents.query = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + encoding.query(parameters)

        return urlComponents.url!
    }
}
