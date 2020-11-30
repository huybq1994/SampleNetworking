//
//  AnyEncodable.swift
//  SampleNetworking
//
//  Created by Huy on 11/30/20.
//

import Foundation

struct AnyEncodable: Encodable {

    private let encodable: Encodable

    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }

    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
