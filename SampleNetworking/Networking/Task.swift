//
//  Task.swift
//  SampleNetworking
//
//  Created by Huy on 11/30/20.
//

import Foundation

public enum Task {
    case requestWithParameters([String: Any], encoding: URLEncoding)
    case requestWithEncodable(Encodable)
}
