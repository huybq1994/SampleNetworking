//
//  ViewController.swift
//  SampleNetworking
//
//  Created by Huy on 11/30/20.
//

import UIKit

class ViewController: UIViewController {

    let networking = Networking<Photo>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        networking.request(resource: .photo(id: "1")) { result in
            switch result {
            case let .success(response):
                let value = try? response.map(to: PhotoModel.self)
                print(value)
            case let .failure(error):
                print(error.errorDescription ?? "")
            }
        }
    }
}

struct PhotoModel: Decodable {
    var id: Int?
}

enum Photo {
    case me
    case photo(id: String)
    case collection(id: String)
    case likePhoto(id: String)
}

extension Photo: Resource {
    var baseURL: URL {
        return URL(string: "https://api.unsplash.com")!
    }

    var endpoint: Endpoint {
        switch self {
        case .me:
            return .get(path: "/me")
        case let .photo(id: id):
            return .get(path: "/photos/\(id)")
        case let .collection(id: id):
            return .get(path: "/collections/\(id)")
        case let .likePhoto(id: id):
            return .post(path: "/photos/\(id)/like")
        }
    }

    var task: Task {
        var params: [String: Any] = [:]
        return .requestWithParameters(params, encoding: URLEncoding())
    }

    var headers: [String: String] {
        return ["Authorization": "Bearer xxx"]
    }

    var cachePolicy: URLRequest.CachePolicy {
        return .useProtocolCachePolicy
    }
}


