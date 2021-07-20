//
//  SerachNetworkService.swift
//  dummyYummy
//
//  Created by badyi on 19.07.2021.
//

import UIKit

enum SearchCancelType {
    case search, imageLoad, recipe
}

final class SearchNetworkService {
    let networkHelper = NetworkHelper(reachability: FakeReachability())
    var currentSearchRequest: Cancellation?
    var imageLoadRequests = [IndexPath: Cancellation]()
}

extension SearchNetworkService: SearchNetworkServiceProtocol {
    func loadSearch(_ query: String, completion: @escaping(OperationCompletion<SearchResponse>) -> Void) {
        guard let resource = SearchNetworkResourceFactory().createSearchRecipesResource(query) else {
            let error = NSError(domain: "Search recipe resource create error", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }
        if currentSearchRequest != nil {
            cancelSearchRequest()
            cancelLoadAllImages()
        }

        currentSearchRequest = load(resource: resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func loadImage(at index: IndexPath, with url: String, completion: @escaping(OperationCompletion<Data>) -> Void) {
        guard let resource = SearchNetworkResourceFactory().createImageResource(url) else {
            let error = NSError(domain: "Image resource create error", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }

        if imageLoadRequests[index] != nil {
            return
        }

        imageLoadRequests[index] = load(resource: resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}

private extension SearchNetworkService {
    func load<T>(resource: Resource<T>, completion: @escaping(OperationCompletion<T>) -> Void) -> Cancellation? {
        let cancel = networkHelper.load(resource: resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        return cancel
    }

    func cancelSearchRequest() {
        guard let request = currentSearchRequest else {
            return
        }
        request.cancel()
        currentSearchRequest = nil
    }

    func cancelLoadAllImages() {
        imageLoadRequests.forEach {
            $0.value.cancel()
        }
        imageLoadRequests.removeAll()
    }
}