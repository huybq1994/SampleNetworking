//
//  URLEncoding.swift
//  SampleNetworking
//
//  Created by Huy on 11/30/20.
//

import Foundation

public struct URLEncoding {
    public enum ArrayEncoding {
        case brackets
        case noBrackets

        public func encode(key: String) -> String {
            switch self {
            case .brackets:
                return "\(key)[]"
            case .noBrackets:
                return key
            }
        }
    }

    public enum BoolEncoding {
        case numeric
        case literal

        public func encode(flag: Bool) -> String {
            switch self {
            case .numeric:
                return flag ? "1" : "0"
            case .literal:
                return flag.description
            }
        }
    }

    public let arrayEncoding: ArrayEncoding
    public let boolEncoding: BoolEncoding
    public let destination: ParamDestination?

    public init(destination: ParamDestination? = nil, arrayEncoding: ArrayEncoding = .brackets, boolEncoding: BoolEncoding = .literal) {
        self.arrayEncoding = arrayEncoding
        self.boolEncoding = boolEncoding
        self.destination = destination
    }
    
    public func query(_ parameters: [String: Any]) -> String {
        var components = [(String, String)]()

        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }

        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }

    private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components = [(String, String)]()

        if let dictionary = value as? [String: Any] {
            for (innerKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(innerKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: arrayEncoding.encode(key: key), value: value)
            }
        } else if let flag = value as? Bool {
            components.append((key, boolEncoding.encode(flag: flag)))
        } else {
            components.append((key, "\(value)"))
        }

        return components
    }
}
