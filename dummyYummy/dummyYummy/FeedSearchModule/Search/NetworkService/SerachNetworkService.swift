//
//  SerachNetworkService.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import UIKit

final class SearchNetworkService {
    let networkHelper = NetworkHelper(reachability: Reachability())

    private var currentSearchRequest: TaskItem?
    private var imageLoadRequests = [String: Cancellation]()
}

extension SearchNetworkService: SearchNetworkServiceProtocol {
    func loadSearch(_ query: String, completion: @escaping(OperationCompletion<SearchResponse>) -> Void) {

        if currentSearchRequest?.query == query, currentSearchRequest?.searchTask != nil {
            completion(.failure(ServiceError.alreadyLoading))
            return
        }
        currentSearchRequest = TaskItem()
        currentSearchRequest?.query = query

        guard let resource = SearchNetworkResourceFactory().createSearchRecipesResource(query) else {
            completion(.failure(ServiceError.resourceCreatingError))
            return
        }

        currentSearchRequest?.searchTask = load(resource, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
            self?.currentSearchRequest = nil
        })
    }

    func loadImage(with url: String, completion: @escaping(OperationCompletion<Data>) -> Void) {
        guard let resource = SearchNetworkResourceFactory().createImageResource(url) else {
            completion(.failure(ServiceError.resourceCreatingError))
            return
        }

        if imageLoadRequests[url] != nil {
            return
        }

        imageLoadRequests[url] = load(resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func cancelImageLoad(with url: String) {
        imageLoadRequests[url]?.cancel()
        imageLoadRequests[url] = nil
    }

    func cancelCurrenSearch() {
        currentSearchRequest?.searchTask?.cancel()
        currentSearchRequest = nil
    }

    func cancelLoadAllImages() {
        imageLoadRequests.forEach {
            $0.value.cancel()
        }
        imageLoadRequests = [:]
    }
}

private extension SearchNetworkService {
    struct TaskItem {
        var query: String?
        var searchTask: Cancellation?
    }
}
