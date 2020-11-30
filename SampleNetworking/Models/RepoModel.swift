//
//  RepoModel.swift
//  SampleNetworking
//
//  Created by Huy on 11/30/20.
//

import Foundation

struct SearchResponse: Decodable {
    let items: [RepoModel]
}

struct RepoModel: Decodable {
    let id: Int
    let name: String
}
