//
//  ReposViewModel.swift
//  SampleNetworking
//
//  Created by Huy on 11/30/20.
//

import Foundation


final class ReposViewModel {
    // Outputs
    var isRefreshing: ((Bool) -> Void)?
    var didUpdateRepos: (([RepoViewModel]) -> Void)?
    var didSelecteRepo: ((Int) -> Void)?

    private(set) var repos: [RepoModel] = [RepoModel]() {
        didSet {
            didUpdateRepos?(repos.map { RepoViewModel(repo: $0) })
        }
    }

    private let throttle = Throttle(minimumDelay: 0.3)
    private var currentSearchNetworkTask: URLSessionDataTask?
    private var lastQuery: String?

    // Dependencies
    private let networkingService: Networking<Repo>
//
    init(networkingService: Networking<Repo>) {
        self.networkingService = networkingService
    }

    // Inputs
    func ready() {
        isRefreshing?(true)
        networkingService.request(resource: .search(name: "swift")) { result in
            switch result {
            case let .success(response):
                let value = try? response.map(to: SearchResponse.self)
                self.finishSearching(with: value?.items ?? [])
            case let .failure(error):
                print(error.errorDescription ?? "")
            }
        }
    }

    func didChangeQuery(_ query: String) {
        guard query.count > 2,
            query != lastQuery else { return } // distinct until changed
        lastQuery = query

        throttle.throttle {
            self.startSearchWithQuery(query)
        }
    }

    func didSelectRow(at indexPath: IndexPath) {
        if repos.isEmpty { return }
        didSelecteRepo?(repos[indexPath.item].id)
    }

    // Private
    private func startSearchWithQuery(_ query: String) {
        currentSearchNetworkTask?.cancel() // cancel previous pending request

        isRefreshing?(true)

        currentSearchNetworkTask = networkingService.request(resource: .search(name: query)) { result in
            switch result {
            case let .success(response):
                let value = try? response.map(to: SearchResponse.self)
                self.finishSearching(with: value?.items ?? [])
            case let .failure(error):
                print(error.errorDescription ?? "")
            }
        }
    }

    private func finishSearching(with repos: [RepoModel]) {
        isRefreshing?(false)
        self.repos = repos
    }
}

struct RepoViewModel {
    let name: String
}

extension RepoViewModel {
    init(repo: RepoModel) {
        self.name = repo.name
    }
}
