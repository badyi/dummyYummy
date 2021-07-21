//
//  File.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

final class FeedNetworkService {
    let networkHelper = NetworkHelper(reachability: FakeReachability())
    var imageLoadTaskContainer = [IndexPath: Cancellation]()
}

// MARK: - FeedServiceProtocol
extension FeedNetworkService: FeedServiceProtocol {
    func loadRandomRecipes(_ count: Int, completion: @escaping(OperationCompletion<RecipesResponse>) -> Void) {
        guard let resource = FeedResourceFactory().createRandomRecipesResource(count) else {
            completion(.failure(ServiceError.resourceCreatingError))
            return
        }

        _ = load(resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func loadImage(at indexPath: IndexPath,
                   with url: String,
                   completion: @escaping(OperationCompletion<Data>) -> Void) {

        if imageLoadTaskContainer[indexPath] != nil {
            return
        }

        guard let resource = FeedResourceFactory().createImageResource(url) else {
            completion(.failure(ServiceError.resourceCreatingError))
            return
        }

        imageLoadTaskContainer[indexPath] = load(resource, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
            self?.removeRequest(at: indexPath)
        })
    }

    func cancelRequest(at index: IndexPath) {
        imageLoadTaskContainer[index]?.cancel()

        imageLoadTaskContainer[index] = nil
    }
}

// MARK: - Private methods
private extension FeedNetworkService {
    func removeRequest(at index: IndexPath) {
        imageLoadTaskContainer[index] = nil
    }
}
